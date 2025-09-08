-- [[ Configure Neotest ]]
-- see :help neotest
--
require("neotest").setup({
  -- log_level = vim.log.levels.DEBUG,
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
      args = { "-vv" },
      pytest_discover_instances = true,
    }),
    require("neotest-rust")({}),
    require('neotest-jest')({
      -- jestCommand = "yarn test",
      -- jestConfigFile = "jest.config.mjs",
      -- cwd = function() return vim.fn.getcwd() end,
      isTestFile = function(file_path)
        if not file_path then
          return false
        end
        -- The default only matches on files with extension, not "test.ts" or "spec.js"
        for _, pattern in ipairs({ "test.[jt]sx?$", "spec.[jt]sx?$" }) do
          if file_path:match(pattern) then
            return true
          end
        end
        if require("neotest-jest.jest-util").defaultIsTestFile(file_path) then
          return true
        end
        return false
      end
      -- jest_test_discovery = true,
    }),
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
