return require('packer').startup({function()

    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- Telescope
    use { 'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-file-browser.nvim' }
      }
    }

    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- harpoon
    use 'ThePrimeagen/harpoon'
    use 'nvim-lua/plenary.nvim'

    -- Color scheme
    use 'gruvbox-community/gruvbox'

    -- Comments++
    use { 'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- Git Worktrees
    use 'ThePrimeagen/git-worktree.nvim'

    -- Fugitive for Git
    use 'tpope/vim-fugitive'
    use 'kdheepak/lazygit.nvim'
    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Vim surround
    -- use 'tpope/vim-surround'

    -- Status line
    -- use 'itchyny/lightline.vim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Some help
    use 'vim-utils/vim-man'

    -- LSP and completion
    -- Language servers need to be installed
    -- with :LspInstall <lang> and the client needs to be
    -- attached to them, check :h lsp
    -- use 'williamboman/nvim-lsp-installer' -- setup plugin ???
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp' -- Auto-completion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer' -- Buffer source for nvim-cmp
    use 'hrsh7th/cmp-path' -- Path source for nvim-cmp
    use 'hrsh7th/cmp-cmdline' -- Cmdline source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippet plugin
    use 'hrsh7th/cmp-nvim-lua'
    use 'onsails/lspkind-nvim'
 	  use {'tzachar/cmp-tabnine', run='./install.sh'} -- tabnine source for nvim-cmp

    -- Treesitter for better code syntax highlighting
    -- Language parsers need to be installed independently with TSInstall <lang>
    -- We recommend updating the parsers on update
    use { 'nvim-treesitter/nvim-treesitter', run= ':TSUpdate'}
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Snippets and integration with k8s
    -- use 'andrewstuart/vim-kubernetes'

    -- Show me indentantion marks
    use 'Yggdroot/indentLine'

    -- ALE (Asynchronous Lint Engine)
    -- use 'dense-analysis/ale'

    -- Rego syntax support
    -- use 'tsandall/vim-rego'
    -- use 'sbdchd/neoformat'

    -- Logstash syntax support
    -- use 'robbles/logstash.vim'

    -- floaterm
    use 'voldikss/vim-floaterm'


    -- gh copilot
    -- use 'github/copilot.vim'

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
