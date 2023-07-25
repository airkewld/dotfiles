vim.api.nvim_set_keymap('n', '<C-n>', [[<cmd>:NvimTreeToggle<CR>]], { noremap = true, silent = true })

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
      view = {
        float = {
          enable = true,
        },
      },
    } -- END_DEFAULT_OPTS
