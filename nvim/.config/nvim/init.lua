-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'lazy-bootstrap'
require 'lazy-plugins'
require 'options'
require 'keymaps'
require 'highlight-yank'
require 'telescope-setup'
require 'treesitter-setup'
require 'neotest-setup'
require 'lsp-setup'
require 'lsp-autoformat-setup'
require 'dap-setup'
require 'nvim-tree-setup'
require 'security-scan'
require 'formatter-setup'
require 'limit-buffers'


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
