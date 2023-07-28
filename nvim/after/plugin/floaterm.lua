-- cwd term
-- vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>:FloatermToggle<CR>]], { noremap = true, silent = true })
-- sleep
vim.api.nvim_set_keymap('n', '<leader>cff', [[<cmd>:FloatermNew --name=sleep caffeinate -d<CR>]],{ noremap = true, silent = true })
-- tmux
vim.api.nvim_set_keymap('n', '<leader>tm', [[<cmd>:FloatermNew --name=tmux ~/.config/tmux.sh<CR>]],{ noremap = true, silent = true })
