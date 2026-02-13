--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.vimwiki_list = { { path = '~/work/obsidian/notes/', syntax = 'markdown', ext = '.md' } }
vim.g.vimwiki_global_ext = 0

-- [[ Install `lazy.nvim` plugin manager ]]
require('lazy-bootstrap')

-- [[ Configure plugins ]]
require('lazy-plugins')

-- [[ Setting options ]]
require('options')

-- [[ Basic Keymaps ]]
require('keymaps')

-- [[ Configure Telescope ]]
-- (fuzzy finder)
-- require('telescope-setup')
-- vim.cmd(
--   [[autocmd VimEnter * lua require('telescope').extensions.git_worktree.git_worktrees()]])

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require('treesitter-setup')

-- [[ Configure LSP ]]
-- (Language Server Protocol)
require('lsp-setup')

-- [[ Configure nvim-cmp ]]
-- (completion)
require('cmp-setup')

-- [[ LSP Log Management ]]
-- Clean up LSP log file if it exceeds 10MB on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local log_path = vim.fn.stdpath("state") .. "/lsp.log"
    local stat = vim.loop.fs_stat(log_path)
    if stat and stat.size > 10 * 1024 * 1024 then -- 10MB
      -- Truncate the log file
      local file = io.open(log_path, "w")
      if file then
        file:write("[LOG TRUNCATED] File exceeded 10MB limit\n")
        file:close()
        vim.notify("LSP log file was truncated (exceeded 10MB)", vim.log.levels.INFO)
      end
    end
  end,
  desc = "Cleanup LSP log file if too large"
})


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
