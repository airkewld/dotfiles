-- ABOUTME: Manages multiple named Claude sessions with idle detection
-- ABOUTME: Provides create/remove/cycle operations and shared window state

local terminal = require('claude.terminal')

local M = {}

local IDLE_TIMEOUT_MS = 3000

local state = {
  sessions = {},
  active = 0,
  winnr = nil,
  counter = 0,
}

local function stop_idle_timer(session)
  if session.idle_timer then
    session.idle_timer:stop()
    session.idle_timer:close()
    session.idle_timer = nil
  end
end

local function session_visible(session)
  return state.winnr
    and vim.api.nvim_win_is_valid(state.winnr)
    and state.sessions[state.active] == session
end

local function watch_output(session)
  vim.api.nvim_buf_attach(session.bufnr, false, {
    on_lines = function()
      if not session.is_alive then return true end
      session.notified_idle = false
      stop_idle_timer(session)
      session.idle_timer = vim.uv.new_timer()
      session.idle_timer:start(IDLE_TIMEOUT_MS, 0, vim.schedule_wrap(function()
        if not session_visible(session) and session.is_alive and not session.notified_idle then
          session.notified_idle = true
          vim.notify('Claude (' .. session.name .. ') is waiting for input', vim.log.levels.INFO)
        end
      end))
    end,
  })
end

function M.create(name)
  if vim.fn.executable('claude') ~= 1 then
    vim.notify('claude: not found in PATH', vim.log.levels.ERROR)
    return nil
  end

  if not name then
    state.counter = state.counter + 1
    name = 'session-' .. state.counter
  end

  for _, s in ipairs(state.sessions) do
    if s.name == name then
      vim.notify('Claude session "' .. name .. '" already exists', vim.log.levels.ERROR)
      return nil
    end
  end

  local bufnr, job_id = terminal.create()
  local session = {
    name = name,
    bufnr = bufnr,
    job_id = job_id,
    is_alive = true,
    idle_timer = nil,
    notified_idle = false,
  }

  table.insert(state.sessions, session)
  state.active = #state.sessions
  watch_output(session)
  return session
end

function M.remove(index)
  local session = state.sessions[index]
  if not session then return end

  stop_idle_timer(session)
  if vim.api.nvim_buf_is_valid(session.bufnr) then
    vim.api.nvim_buf_delete(session.bufnr, { force = true })
  end

  table.remove(state.sessions, index)

  if #state.sessions == 0 then
    state.active = 0
  elseif state.active > #state.sessions then
    state.active = #state.sessions
  elseif state.active > index then
    state.active = state.active - 1
  end
end

function M.get_active()
  return state.sessions[state.active]
end

function M.set_active(index)
  if index >= 1 and index <= #state.sessions then
    state.active = index
  end
end

function M.next()
  if #state.sessions <= 1 then return end
  state.active = (state.active % #state.sessions) + 1
end

function M.prev()
  if #state.sessions <= 1 then return end
  state.active = ((state.active - 2) % #state.sessions) + 1
end

function M.list()
  return state.sessions
end

function M.count()
  return #state.sessions
end

function M.active_index()
  return state.active
end

function M.find_by_bufnr(bufnr)
  for i, s in ipairs(state.sessions) do
    if s.bufnr == bufnr then
      return i, s
    end
  end
  return nil, nil
end

function M.on_exit(bufnr)
  local index, session = M.find_by_bufnr(bufnr)
  if not session then return end

  session.is_alive = false
  stop_idle_timer(session)

  if not session_visible(session) then
    vim.notify('Claude (' .. session.name .. ') session ended', vim.log.levels.INFO)
  end
end

function M.get_winnr()
  return state.winnr
end

function M.set_winnr(winnr)
  state.winnr = winnr
end

return M
