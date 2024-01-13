-- [[ Configure Neotest ]]
-- see :help neotest
--
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
      args = {"-vv"},
    }),
    require("neotest-rust")({}),
  },
})

-- set keymaps
require('which-key').register {
  ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
}

vim.keymap.set('n', '<leader>tn', require('neotest').run.run, { desc = '[T]est [N]earest' })
vim.keymap.set('n', '<leader>tt', require('neotest').run.run_last, { desc = '[T]est Last' })
vim.keymap.set('n', '<leader>ta', function()
  local neotest = require("neotest")
  neotest.output_panel.open()
  neotest.output_panel.clear()
  neotest.run.run(vim.loop.cwd())
end,{ desc = '[T]est [A]ll Files' })
vim.keymap.set('n', '<leader>ts', require('neotest').summary.toggle, { desc = '[T]est [S]ummary' })
vim.keymap.set('n', '<leader>to', require('neotest').output_panel.toggle, { desc = '[T]est [O]utput' })
vim.keymap.set('n', '<leader>tO', function() require('neotest').output.open({enter = true, auto_close = true }) end,{ desc = 'Floating [T]est [O]utput' })


