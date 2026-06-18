-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'plugins'

require 'dap-setup'
require 'formatter-setup'
require 'highlight-yank'
require 'keymaps'
require 'limit-buffers'
require 'lsp-autoformat-setup'
require 'lsp-setup'
require 'neotest-setup'
require 'nvim-tree-setup'
require 'options'
require 'security-scan'
require 'telescope-setup'
require 'treesitter-setup'


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
