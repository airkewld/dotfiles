# claude.nvim

Neovim plugin for running multiple Claude Code sessions in floating terminal windows with a Harpoon-style session picker.

## Setup

```lua
-- lazy.nvim
{
  dir = '~/path/to/claude',
  config = function() require('claude').setup() end,
}
```

## Default Configuration

All values below are defaults. Pass a table to `setup()` to override any of them.

```lua
require('claude').setup({
  idle_timeout_ms = 3000,
  window = {
    width = 0.8,     -- fraction of editor width
    height = 0.8,    -- fraction of editor height
    border = 'rounded',
  },
  menu = {
    width = 0.5,     -- fraction of editor width
    border = 'rounded',
  },
  keymaps = {
    toggle = '<leader>cl',
    sessions = '<leader>cs',
    new_session = '<leader>cn',
  },
})
```

Set any keymap to `false` to disable it.

## Keymaps

| Key | Action |
|-----|--------|
| `<leader>cl` | Toggle active session (creates one if none exist) |
| `<leader>cs` | Open sessions menu |
| `<leader>cn` | Prompt for name and create a new session |

## Commands

| Command | Action |
|---------|--------|
| `:Claude` | Toggle active session |
| `:Claude new [name]` | Create a new session (auto-named if no name given) |
| `:Claude sessions` | Open the sessions menu |
| `:Claude next` | Switch to the next session |
| `:Claude prev` | Switch to the previous session |

## Sessions Menu

The sessions menu is a floating buffer listing all sessions. Buffer-local keymaps:

| Key | Action |
|-----|--------|
| `<CR>` | Select session under cursor |
| `d` | Delete session under cursor |
| `q` / `<Esc>` | Close menu |
