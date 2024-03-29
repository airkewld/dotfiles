require("airkewld")
--
-- Some local variables for better readability
local fn = vim.fn
local execute = vim.api.nvim_command
local cmd = vim.cmd

-- Auto install packer.nvim if it doesn't exist
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    print "Installing packer, close and reopen Neovim..."
    cmd [[packadd packer.nvim]]
end

-- Auto update plugins and compile packer when changes are made on plugins.lua
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])
cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=180})
augroup END
]]
vim.g.vimwiki_list = { { path = '~/vimwiki', syntax = 'markdown', ext = '.md' } }
