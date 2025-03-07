-- [[ Configure Neotest ]]
-- see :help neotest
--
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
      args = { "-vv", "--color=no" },
    }),
    require("neotest-rust")({}),
    require('neotest-jest')({}),
  },
})

-- set keymaps
local wk = require('which-key')
wk.add({
  { "<leader>t",  group = "[T]est" },
  { '<leader>tn', require('neotest').run.run,             desc = '[T]est [N]earest' },
  { '<leader>tt', require('neotest').run.run_last,        desc = '[T]est Last' },
  { '<leader>ts', require('neotest').summary.toggle,      desc = '[T]est [S]ummary' },
  { '<leader>to', require('neotest').output_panel.toggle, desc = '[T]est [O]utput' },
  {
    '<leader>ta',
    function()
      local neotest = require("neotest")
      neotest.summary.open()
      neotest.run.run(vim.loop.cwd())
    end,
    desc = '[T]est [A]ll Files'
  },
  {
    '<leader>tO',
    function() require('neotest').output.open({ enter = true, auto_close = true }) end,
    desc = 'Floating [T]est [O]utput'
  },
  { "<leader>td", group = "[T]est [D]ebug" },
  {
    '<leader>tdn',
    function()
      require('neotest').run.run({ strategy = 'dap' })
    end,
    desc = '[T]est [D]ebug [N]earest'
  },
})
