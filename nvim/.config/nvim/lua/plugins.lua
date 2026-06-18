-- Install plugins
--
-- Some plugins might need configuration and expect a `setup()` call

local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
  -- install the theme before anything else
  { src = gh('navarasu/onedark.nvim'), version = vim.version.range('1.0.3') },
})
require('onedark').setup({ style = 'darker' })
require('onedark').load()

vim.pack.add({
  -- Change the status line
  { src = gh('nvim-lualine/lualine.nvim') },

  -- Adds git related signs to the gutter and some change utilities
  { src = gh('lewis6991/gitsigns.nvim'),          version = vim.version.range('2.1.0') },

  -- Useful plugin to show you pending keybinds.
  { src = gh('folke/which-key.nvim'),             version = vim.version.range('3.17.0') },
  -- file tree explorer
  { src = gh('nvim-tree/nvim-tree.lua') },
  { src = gh('nvim-tree/nvim-web-devicons') },

  -- fuzzy finder and file pickers
  { src = gh('nvim-telescope/telescope.nvim'),    version = vim.version.range('0.2.1') },
  -- dependencies of telescope
  { src = gh('nvim-lua/plenary.nvim') },
  { src = gh('nvim-telescope/telescope-dap.nvim') },
  -- native fuzzy finder, needs a build step which i did not figure out yet
  -- {src = gh('nvim-telescope/telescope-fzf-native.nvim')},

  -- LSP protocol
  { src = gh('neovim/nvim-lspconfig'),            version = vim.version.range('2.10.0') },
  { src = gh('folke/lazydev.nvim'),               version = vim.version.range('*') },
  { src = gh('mason-org/mason.nvim'),             version = vim.version.range('2.3.1') },
  { src = gh('mason-org/mason-lspconfig.nvim'),   version = vim.version.range('2.3.0') },

  -- progress notifications
  { src = gh('j-hui/fidget.nvim') },

  -- DAP protocol
  { src = gh('mfussenegger/nvim-dap'),            version = vim.version.range('0.10.0') },
  { src = gh('mfussenegger/nvim-dap-python') },
  { src = gh('rcarriga/nvim-dap-ui') },

  -- Neotest
  { src = gh('nvim-neotest/neotest'),             version = vim.version.range('5.18.0') },
  { src = gh('nvim-neotest/nvim-nio'),            version = vim.version.range('1.10.1') },
  { src = gh('nvim-neotest/neotest-python') },
  { src = gh('nvim-neotest/neotest-jest') },
  -- TODO: find a replacement, this plugin is archived.
  { src = gh('rouge8/neotest-rust') },

  -- Code outline
  { src = gh('stevearc/aerial.nvim') },

  -- additional formatter on top of LSP and editorconfig formatting
  { src = gh('mhartington/formatter.nvim') },

  -- CSV formating and highlights
  { src = gh('mechatroner/rainbow_csv') },

  -- vim syntax for justfiles
  { src = gh('NoahTheDuke/vim-just') },

  -- vim syntax for Helm charts
  { src = gh('towolf/vim-helm') },
})

require('lualine').setup({
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
})

require('which-key').setup()
require('fidget').setup({})
require('mason').setup()
require('lazydev').setup()

-- Aerial
local aerial = require("aerial")
aerial.setup({
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
    -- Uncomment this to show variables
    -- "Variable",
  },
  -- Jump to symbol in source window when the cursor moves
  autojump = false,
  layout = {
    default_direction = "float",
  },
  float = {
    relative = "editor",
  },
  close_automatic_events = { "unsupported" },
  close_on_select = true,
  keymaps = {
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<leader>v"] = "actions.jump_vsplit",
    ["<leader>s"] = "actions.jump_split",
    ["h"] = "actions.left",
    ["l"] = "actions.right",
    ["<Esc>"] = "actions.close",
  },
})
vim.keymap.set("n", "<leader>co", aerial.toggle, { desc = "[C]ode [O]utline" })

-- Gitsigns
require('gitsigns').setup({
  -- See `:help gitsigns.txt`
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review hunk' })
    vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = '[R]eset hunk' })
    vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = '[R]eset buffer' })
    vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, { buffer = bufnr, desc = '[B]lame line' })

    -- don't override the built-in and fugitive keymaps
    local gs = package.loaded.gitsigns
    vim.keymap.set({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
    vim.keymap.set({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
  end,

})
