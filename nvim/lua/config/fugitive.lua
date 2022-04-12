-- vim.api.nvim_set_keymap('n', '<space>G', ':G', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gg', [[<cmd>:G<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gps', [[<cmd>:G push<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gpl', [[<cmd>:G pull<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gco', [[<cmd>:G checkout .<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gfe', [[<cmd>:G fetch origin '*:*'<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>:FloatermToggle<CR>]], { noremap = true, silent = true })
