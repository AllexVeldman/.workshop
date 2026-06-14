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
          -- lazydev properly tags releases, use latest stable semver
          version = "*",
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
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'searchcount' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      },
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
      'nvim-telescope/telescope.nvim',
      -- telescope properly tags releases, use latest stable semver
      version = "*",
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
      -- nvim-tree does proper release tagging, use the latest stable semver release.
      version = "*",
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
    -- setup is done in `formatter-setup.lua`
    "mhartington/formatter.nvim",

    -- Format and highlight CSV
    "mechatroner/rainbow_csv",

    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'plugins' },
  }
}, {})
