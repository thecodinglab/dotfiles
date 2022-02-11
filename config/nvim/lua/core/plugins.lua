local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

packer.startup {
  function(use)
    -- Package manager
    use {
      'wbthomason/packer.nvim'
    }

    -- Lua functions
    use {
      "nvim-lua/plenary.nvim",
    }

    -- Popup API
    use {
      "nvim-lua/popup.nvim",
    }

    -- Boost startup time
    use {
      'nathom/filetype.nvim',
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    }

    -- Theme
    use {
      'navarasu/onedark.nvim',
      config = function()
        require('configs.theme').config()
      end,
    }

    -- Icons
    use {
      'kyazdani42/nvim-web-devicons'
    }

    -- Bufferline
    use {
      'akinsho/bufferline.nvim',
      after = 'nvim-web-devicons',
      config = function()
        require('configs.bufferline').config()
      end,
    }

    -- Better buffer closing
    use {
      'moll/vim-bbye',
      after = 'bufferline.nvim',
    }
    
    -- File explorer
    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require 'configs.nvim-tree'.config()
      end,
    }

    -- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      after = 'bufferline.nvim',
      config = function()
        require('configs.lualine').config()
      end,
    }

    -- Syntax highlighting
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufRead',
      cmd = {
        'TSInstall',
        'TSInstallInfo',
        'TSInstallSync',
        'TSUninstall',
        'TSUpdate',
        'TSUpdateSync',
        'TSDisableAll',
        'TSEnableAll',
      },
      config = function()
        require('configs.treesitter').config()
      end,
      requires = {
        {
          -- Parenthesis highlighting
          'p00f/nvim-ts-rainbow',
          after = 'nvim-treesitter',
        },
        {
          -- Autoclose tags
          'windwp/nvim-ts-autotag',
          after = 'nvim-treesitter',
        },
        {
          -- Context based commenting
          'JoosepAlviste/nvim-ts-context-commentstring',
          after = 'nvim-treesitter',
        },
      },
    }

    -- Snippet engine
    use {
      'L3MON4D3/LuaSnip',
      config = function()
        local status_ok, luasnip = pcall(require, 'luasnip/loaders/from_vscode')
        if not status_ok then
          return
        end

        luasnip.lazy_load()
      end,
      requires = {
        -- Snippet collections
        'rafamadriz/friendly-snippets',
      },
    }

    -- Completion engine
    use {
      'hrsh7th/nvim-cmp',
      event = {'BufRead', 'BufNewFile'},
      config = function()
        require('configs.cmp').config()
      end,
    }

    -- Snippet completion source
    use {
      'saadparwaiz1/cmp_luasnip',
      after = 'nvim-cmp',
    }

    -- Buffer completion source
    use {
      'hrsh7th/cmp-buffer',
      after = 'nvim-cmp',
    }

    -- Path completion source
    use {
      'hrsh7th/cmp-path',
      after = 'nvim-cmp',
    }

    -- LSP manager
    use {
      'williamboman/nvim-lsp-installer',
      event = 'BufRead',
      cmd = {
        'LspInstall',
        'LspInstallInfo',
        'LspPrintInstalled',
        'LspRestart',
        'LspStart',
        'LspStop',
        'LspUninstall',
        'LspUninstallAll',
      },
    }

    -- Built-in LSP
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('configs.lsp.init').config()
      end,
      requires = {
        -- LSP completion source
        use {
          'hrsh7th/cmp-nvim-lsp',
        },

      }
    }

    -- vlang
    use {
      'thecodinglab/nvim-vlang',
    }

    -- LSP enhancer
    use {
      'tami5/lspsaga.nvim',
      event = 'BufRead',
      config = function()
        require('configs.lsp.lspsaga').config()
      end,
    }

    -- LSP symbols
    use {
      'simrat39/symbols-outline.nvim',
      cmd = 'SymbolsOutline',
      setup = function()
        require('configs.symbols-outline').setup()
      end,
    }

    -- Formatting and linting
    use {
      'jose-elias-alvarez/null-ls.nvim',
      event = 'BufRead',
      config = function()
        require 'configs.null-ls'.config()
      end,
    }

    -- Fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      config = function()
        require('configs.telescope').config()
      end,
    }

    -- Fuzzy finder syntax support
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    }

    -- Git integration
    use {
      'lewis6991/gitsigns.nvim',
      event = 'BufRead',
      config = function()
        require('configs.gitsigns').config()
      end,
    }

    -- Color highlighting
    -- use {
    --   'norcalli/nvim-colorizer.lua',
    --   event = 'BufRead',
    --   config = function()
    --     require('configs.colorizer').config()
    --   end,
    --   disable = not configs.enabled.colorizer,
    -- }

    -- Autopairs
    use {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('configs.autopairs').config()
      end,
    }

    -- Commenting
    use {
      'numToStr/Comment.nvim',
      event = 'BufRead',
      config = function()
        require('configs.comment').config()
      end,
    }
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
    },
    auto_clean = true,
    compile_on_sync = true,
  },
}