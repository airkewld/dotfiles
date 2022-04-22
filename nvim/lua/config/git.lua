
vim.api.nvim_set_keymap('n', '<leader>gg', [[<cmd>:LazyGit<CR>]], { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader>gps', [[<cmd>:G push<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>:G pull<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>gco', [[<cmd>:G checkout .<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gfe', [[<cmd>:G fetch origin '*:*'<CR>]], { noremap = true, silent = true })

local utils = require('config.utils')
utils.map('n', '<Leader>gs', '<cmd>G<CR>')
utils.map('n', '<Leader>ga', '<cmd>Git fetch --all<CR>')
utils.map('n', '<Leader>grum', '<cmd>Git rebase upstream/master<CR>')
utils.map('n', '<Leader>grom', '<cmd>Git rebase origin/master<CR>')
utils.map('n', '<Leader>gf', '<cmd>diffget //2<CR>')
utils.map('n', '<Leader>gj', '<cmd>diffget //3<CR>')

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
