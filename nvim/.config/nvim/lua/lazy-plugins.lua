-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- Disable installing luarocks packages
  rocks = { enabled = false },
  spec = {
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',

    -- Detect tabstop and shiftwidth automatically
    -- TODO: See if we can do without vim-sleuth
    'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done in lsp-setup.lua
    {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        {
          'folke/lazydev.nvim',
          ft = "lua", -- only load on lua files
          opts = {},
        },
        -- towolf/vim-helm provides basic syntax highlighting and filetype detection for Helm
        -- ft = 'helm' is important to not start yamlls
        {
          'towolf/vim-helm',
          ft = 'helm'
        },
      },
    },

    -- Debug Adapter Protocol
    'mfussenegger/nvim-dap',
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio', }
    },
    'mfussenegger/nvim-dap-python',

    {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- Adds LSP completion capabilities
        -- TODO: Switch to builtin LSP completion support
        --  https://gpanders.com/blog/whats-new-in-neovim-0-11/#builtin-auto-completion
        'hrsh7th/cmp-nvim-lsp',
      },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },

    {
      -- Theme inspired by Atom
      'navarasu/onedark.nvim',
      priority = 1000,
      config = function()
        vim.cmd.colorscheme 'onedark'
      end,
    },

    {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
        options = {
          icons_enabled = false,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
        },
      },
    },

    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help ibl`
      main = 'ibl',
      opts = {},
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-dap.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
      },
    },

    {
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
    },
    {
      -- Test runners
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest",
        "rouge8/neotest-rust",
      }
    },
    -- Nvim-tree
    -- File Explorer for Neovim
    {
      "nvim-tree/nvim-tree.lua",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
    },
    -- Vim syntax for justfiles
    {
      "NoahTheDuke/vim-just",
      ft = { "just" },
    },
    -- Run auto-formatting on specific file types
    -- This is separate from any formatting the LSP can do
    "mhartington/formatter.nvim",
    -- Run linters on specific file types
    -- This is on top of lints the LSP might generate
    "mfussenegger/nvim-lint",
    -- nvim-highlight-colors
    -- Shows the color when it detects a color code
    -- https://github.com/brenoprata10/nvim-highlight-colors
    -- {
    --   "brenoprata10/nvim-highlight-colors",
    --   opts = {
    --     render = 'virtual',
    --   },
    -- },
    -- Format and highlight CSV
    "mechatroner/rainbow_csv",

    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'plugins' },
  }
}, {})
