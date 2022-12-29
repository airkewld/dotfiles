vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope the moon
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
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

    -- Git
    use 'tpope/vim-fugitive'
    use 'kdheepak/lazygit.nvim'
    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }
    -- Status line
    -- use 'itchyny/lightline.vim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Treesitter
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    -- floaterm
    use 'voldikss/vim-floaterm'

    use { "anuvyklack/windows.nvim",
       requires = {
          "anuvyklack/middleclass",
          "anuvyklack/animation.nvim"
      },
       config = function()
          vim.o.winwidth = 10
          vim.o.winminwidth = 10
          vim.o.equalalways = false
          require('windows').setup()
       end
    }

    -- git-blame
    use 'f-person/git-blame.nvim'

    -- markdown reader
    use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- vimwiki
    use 'vimwiki/vimwiki'

    -- smooth Scrolling
    use {'karb94/neoscroll.nvim',
      config = function()
          require('neoscroll').setup()
      end
    }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
