-- This does not work since dap_python needs the python executable instead of the debugpy executable
-- dap_python.setup(vim.fn.exepath('debugpy-adapter'))
local python_path = table.concat({ vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/')
    :gsub('//+', '/')
-- local python_path = vim.fn.joinpath({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' })
require('dap-python').setup(python_path)

-- Open DAP-ui on DAP events
local dap, dapui = require("dap"), require("dapui")
dapui.setup({
  element_mappings = {
    stacks = {
      open = "<CR>",
      expand = "o",
    }
  }
})
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

local map = function(mode, keys, func, desc)
  if desc then
    desc = 'DAP: ' .. desc
  end

  vim.keymap.set(mode, keys, func, { desc = desc })
end

-- Keybindings
map('n', '<F5>', function() dap.continue() end, '[C]ontinue')
map('n', '<F8>', function() dap.step_over() end, 'Step Over')
map('n', '<F7>', function() dap.step_into() end, 'Step Into')
map('n', '<S-F8>', function() dap.step_out() end, 'Step Out')
map('n', '<leader>bt', function() dap.toggle_breakpoint() end, '[T]oggle Breakpoint')
map('n', '<leader>bs', function() dap.set_breakpoint() end, '[S]et Breakpoint')
map('n', '<leader>bd', function() dap.clear_breakpoints() end, '[D]elete All Breakpoints')
map('n', '<leader>dt', function() dapui.toggle() end, '[T]oggle the debug view')
map({ 'n', 'v' }, '<leader>de', function() dapui.eval() end, '[E]valuate current cursor')
map('n', '<leader>du', dap.up, 'Stack [U]p')
map('n', '<leader>dd', dap.down, 'Stack [D]own')
