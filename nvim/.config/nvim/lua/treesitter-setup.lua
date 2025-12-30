-- [[ Configure Treesitter ]]
-- Parses code to ASTs to provide syntax highlighting etc.
-- See `:help nvim-treesitter`

require('nvim-treesitter').install({
  'c',
  'cpp',
  'go',
  'lua',
  'python',
  'rust',
  'tsx',
  'javascript',
  'typescript',
  'vimdoc',
  'vim',
  'bash',
  'json',
  'toml',
  'graphql',
  'yaml',
})


-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'lua' },
--   callback = function() vim.treesitter.start() end,
-- })

-- Enable folding using treesitter
-- `zi` to enable folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldenable = false
