-- vim.api.nvim_set_keymap('n', '<leader>gps', [[<cmd>:G push<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>:G pull<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gco', [[<cmd>:G checkout .<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gfe', [[<cmd>:G fetch origin '*:*'<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>gs', '<cmd>G<CR>')
vim.keymap.set('n', '<Leader>ga', '<cmd>Git fetch --all<CR>')
vim.keymap.set('n', '<Leader>grum', '<cmd>Git rebase upstream/master<CR>')
vim.keymap.set('n', '<Leader>grom', '<cmd>Git rebase origin/master<CR>')

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
