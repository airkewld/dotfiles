-- vimwiki
vim.g.vimwiki_list = { { path = '~/Documents/Mywiki', syntax = 'markdown', ext = '.md' } }
vim.api.nvim_set_keymap('n', '<leader>lt', [[<cmd>:VimwikiToggleListItem<CR>]], { noremap = true, silent = true })
