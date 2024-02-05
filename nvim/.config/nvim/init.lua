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
require 'cmp-setup'
require 'nvim-tree-setup'
require 'security-scan'
require 'formatter-setup'
require 'lint-setup'

vim.api.nvim_create_user_command('ListPlugins', function()
  local M = require('lazy')
  for _, v in pairs(M.plugins()) do
    vim.print(v[1])
  end
end, {})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
