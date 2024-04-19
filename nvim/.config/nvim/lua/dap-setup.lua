-- This does not work since dap_python needs the python executable instead of the debugpy executable
-- dap_python.setup(vim.fn.exepath('debugpy-adapter'))
local python_path = table.concat({ vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/')
    :gsub('//+', '/')
-- local python_path = vim.fn.joinpath({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' })
require('dap-python').setup(python_path)

-- Load configurations from .vscode/launch.json
require('dap.ext.vscode').load_launchjs()

-- Open DAP-ui on DAP events
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Keybindings
vim.keymap.set('n', '<leader>bc', function() require('dap').continue() end, { desc = '[C]ontinue' })
vim.keymap.set('n', '<leader>bo', function() require('dap').step_over() end, { desc = 'Step [O]ver' })
vim.keymap.set('n', '<leader>bi', function() require('dap').step_into() end, { desc = 'Step [I]nto' })
vim.keymap.set('n', '<leader>bO', function() require('dap').step_out() end, { desc = 'Step [O]ut' })
vim.keymap.set('n', '<Leader>bt', function() require('dap').toggle_breakpoint() end, { desc = '[T]oggle Breakpoint' })
vim.keymap.set('n', '<Leader>bs', function() require('dap').set_breakpoint() end, { desc = '[S]et Breakpoint' })
vim.keymap.set('n', '<Leader>bd', function() require('dap').clear_breakpoints() end,
    { desc = '[D]elete All Breakpoints' })
