-- ABOUTME: Public API for the Claude Code Neovim plugin
-- ABOUTME: Wires keymaps, commands, and autocmds to session and menu modules

local config = require('claude.config')
local window = require('claude.window')
local session = require('claude.session')
local menu = require('claude.menu')

local M = {}

local function win_visible()
  local winnr = session.get_winnr()
  return winnr and vim.api.nvim_win_is_valid(winnr)
end

local function hide()
  local winnr = session.get_winnr()
  if winnr and vim.api.nvim_win_is_valid(winnr) then
    vim.api.nvim_win_hide(winnr)
    session.set_winnr(nil)
  end
end

local function show(s)
  local winnr = window.open(s.bufnr, s.name)
  session.set_winnr(winnr)
  vim.cmd('startinsert')
end

function M.switch_to_active()
  local s = session.get_active()
  if not s then return end

  local winnr = session.get_winnr()
  if winnr and vim.api.nvim_win_is_valid(winnr) then
    vim.api.nvim_win_set_buf(winnr, s.bufnr)
    window.set_title(winnr, s.name)
    vim.cmd('startinsert')
  else
    show(s)
  end
end

function M.hide_window()
  hide()
end

local function toggle()
  local s = session.get_active()

  if not s or not vim.api.nvim_buf_is_valid(s.bufnr) then
    session.create()
    s = session.get_active()
    if not s then return end
    show(s)
    return
  end

  if win_visible() then
    hide()
    return
  end

  show(s)
end

local subcommands = {
  new = function(args)
    local name = args[1]
    local s = session.create(name)
    if s then M.switch_to_active() end
  end,
  sessions = function()
    menu.open()
  end,
  next = function()
    session.next()
    if win_visible() then M.switch_to_active() end
  end,
  prev = function()
    session.prev()
    if win_visible() then M.switch_to_active() end
  end,
}

local function new_session_prompt()
  vim.ui.input({ prompt = 'Session name: ' }, function(name)
    if not name or name == '' then return end
    local s = session.create(name)
    if s then M.switch_to_active() end
  end)
end

function M.setup(opts)
  config.setup(opts)
  local keys = config.get().keymaps

  local function map(key, fn, desc)
    if key then vim.keymap.set('n', key, fn, { desc = desc }) end
  end
  map(keys.toggle, toggle, 'Toggle Claude Code')
  map(keys.sessions, menu.open, 'Claude sessions menu')
  map(keys.new_session, new_session_prompt, 'New named Claude session')

  vim.api.nvim_create_user_command('Claude', function(cmd)
    local args = cmd.fargs
    local sub = args[1]
    if not sub then
      toggle()
      return
    end
    local handler = subcommands[sub]
    if handler then
      handler({ unpack(args, 2) })
    else
      vim.notify('Claude: unknown subcommand "' .. sub .. '"', vim.log.levels.ERROR)
    end
  end, {
    nargs = '*',
    complete = function(_, line)
      local parts = vim.split(line, '%s+')
      if #parts <= 2 then
        local prefix = parts[2] or ''
        local matches = {}
        for name, _ in pairs(subcommands) do
          if name:find(prefix, 1, true) == 1 then
            table.insert(matches, name)
          end
        end
        table.sort(matches)
        return matches
      end
      return {}
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'ClaudeExit',
    callback = function(ev)
      local bufnr = ev.data and ev.data.bufnr
      if bufnr then
        session.on_exit(bufnr)
      end
    end,
  })

  vim.api.nvim_create_autocmd('VimResized', {
    callback = function()
      if win_visible() then
        window.resize(session.get_winnr())
      end
    end,
  })

  vim.api.nvim_create_autocmd('WinClosed', {
    callback = function(ev)
      local winnr = session.get_winnr()
      if winnr and tostring(winnr) == ev.match then
        session.set_winnr(nil)
      end
    end,
  })
end

return M
