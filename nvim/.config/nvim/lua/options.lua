-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--  This is disabled in favor of explicit clipboard management
--  `"'` will swap the last-yanked text with the system clipboard so yanks form nvim can be pasted elsewhere
--  `"+p` will paste from the system clipboard, see `:help registers`
--  in Insert mode Ctrl-V will paste from the system clipboard
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Add column stop indicator
vim.o.colorcolumn = "88"

-- Enable tabbreak
-- Will insert 4 spaces instead of a tab
vim.o.tabstop = 4
vim.o.expandtab = true

-- show whitespace characters
-- Replaces the use of a plugin like indent-blankline
vim.o.listchars = 'tab:> ,leadmultispace:┊   '
vim.o.list = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Enable auto-reload on external file changes
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Spellcheck by default
vim.wo.spell = true

-- Diagnostic settings

-- Remove ansi escape codes from a Diagnostic message
-- Useful if for example test output contains color codes
-- This allows a normal output window to show color but inline
-- diagnostics to show up in just red
--- @param s vim.Diagnostic
--- @return string
local function remove_ansi_escapes(s)
  return s.message:gsub('\x1b%[%d+;%d+;%d+;%d+;%d+m', '')
      :gsub('\x1b%[%d+;%d+;%d+;%d+m', '')
      :gsub('\x1b%[%d+;%d+;%d+m', '')
      :gsub('\x1b%[%d+;%d+m', '')
      :gsub('\x1b%[%d+m', '')
end

vim.diagnostic.config({
  float = { source = true, format = remove_ansi_escapes },
  -- Show diagnostics inline
  virtual_text = { format = remove_ansi_escapes },
})

-- Diagnostic keymaps
require('which-key').add({
  { '<leader>E', vim.diagnostic.open_float, desc = 'Open floating diagnostic message' },
  { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostics list' },
  {
    mode = 'n',
    {
      '<leader>e',
      function()
        if vim.diagnostic.config().virtual_lines == false then
          vim.diagnostic.config({ virtual_lines = { current_line = true, format = remove_ansi_escapes } })
        else
          vim.diagnostic.config({ virtual_lines = false })
        end
      end,
      desc = 'Toggle diagnostic virtual lines'
    },
  },
})

-- Load .nvim.lua from CWD
vim.o.exrc = true
