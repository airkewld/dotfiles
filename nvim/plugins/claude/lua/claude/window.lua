-- ABOUTME: Creates and manages the floating window for Claude terminal output
-- ABOUTME: Handles show/hide lifecycle with centered positioning

local M = {}

local function make_title(name)
  if name then
    return ' Claude (' .. name .. ') '
  end
  return ' Claude '
end

function M.open(bufnr, name)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local winnr = vim.api.nvim_open_win(bufnr, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = make_title(name),
    title_pos = 'center',
  })

  vim.api.nvim_set_option_value('spell', false, { win = winnr })

  return winnr
end

function M.set_title(winnr, name)
  vim.api.nvim_win_set_config(winnr, {
    title = make_title(name),
    title_pos = 'center',
  })
end

function M.resize(winnr)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_win_set_config(winnr, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
  })
end

return M
