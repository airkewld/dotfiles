-- vim.api.nvim_set_keymap('n', '<space>G', ':G', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>G', [[<cmd>:G<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>:G push<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>:G checkout .<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gpp', [[<cmd>:G pull<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>:G fetch origin '*:*'<CR>]], { noremap = true, silent = true })

