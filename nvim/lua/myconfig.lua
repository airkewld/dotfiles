local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- "require for file_browser
require("telescope").load_extension "file_browser"

-- "require for comments
require('Comment').setup()

require("telescope").load_extension('harpoon')
require("telescope").load_extension('fzf')
require("telescope").load_extension("git_worktree")

require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    ensure_installed = {
      "bash",
      "comment",
      "dockerfile",
      "go",
      "hcl",
      "json",
      "lua",
      "markdown",
      "regex",
      "vim",
      "yaml",
      "",
      "",
    },
    textobjects = { enable = true }
}

require'lspconfig'.dockerls.setup{}

require'lspconfig'.ansiblels.setup{}

require'lspconfig'.bashls.setup{}

require'lspconfig'.diagnosticls.setup{}

-- require'lspconfig'.golangci_lint_ls.setup{}

require'lspconfig'.gopls.setup{
  capabilities = capabilities,
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}

require'lspconfig'.terraformls.setup{}

require'lspconfig'.tflint.setup{}

require'lspconfig'.vimls.setup{}

require'lspconfig'.yamlls.setup{}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

