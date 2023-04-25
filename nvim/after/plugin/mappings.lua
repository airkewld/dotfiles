--- behave like C and D
vim.keymap.set('n', 'Y', 'y$')

--- keep it centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')

--- undo breakpoints
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', '[', '[<c-g>u')
vim.keymap.set('i', '!', '!<c-g>u')
vim.keymap.set('i', '?', '?<c-g>u')

--- window navigation with vim keys
vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<CR>')
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<CR>')
vim.keymap.set('n', '<leader>pv', '<cmd>wincmd v<bar> :Ex <bar> :vertical resize 30<CR>')

-- quick saves
vim.api.nvim_set_keymap('n', '<C-s>', [[<cmd>:w<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-g>', [[<cmd>:FloatermNew --name=tmux /Users/oscar/dev/learn-go/nvim-search/main<CR>]],{ noremap = true, silent = true })
