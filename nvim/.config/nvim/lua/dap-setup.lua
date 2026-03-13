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
  -- dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  -- dapui.open()
end


-- DAP adapter for rust based on lldb
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}


local map = function(mode, keys, func, desc)
  if desc then
    desc = 'DAP: ' .. desc
  end

  vim.keymap.set(mode, keys, func, { desc = desc })
end

-- Keybindings
map('n', '<leader>dr', require('telescope').extensions.dap.configurations, '[R]un')
map('n', '<leader>dt', dapui.toggle, '[T]oggle the debug view')
map('n', '<leader>bt', dap.toggle_breakpoint, '[T]oggle Breakpoint')
map('n', '<leader>bc', function()
  local condition = vim.fn.input("Condition: ")
  dap.toggle_breakpoint(condition)
end, 'Set [C]onditional Breakpoint')
map('n', '<leader>bd', dap.clear_breakpoints, '[D]elete All Breakpoints')
map('n', '<F5>', dap.continue, 'Continue')
-- Keybindings during debug sessions
dap.listeners.after.event_initialized['custom.dap.keys'] = function()
  map('n', '<F8>', dap.step_over, 'Step Over')
  map('n', '<F7>', dap.step_into, 'Step Into')
  map('n', '<S-F8>', dap.step_out, 'Step Out')
  map('n', '<leader>dc', dap.run_to_cursor, 'Run to [C]ursor')
  map({ 'n', 'v' }, '<leader>de', dapui.eval, '[E]valuate current cursor')
  map('n', '<leader>ds', require('telescope').extensions.dap.frames, 'Call [S]tack')
  map('n', '<leader>du', dap.up, 'Stack [U]p')
  map('n', '<leader>dd', dap.down, 'Stack [D]own')
  map('n', '<leader>dk', dap.terminate, '[K]ill debug session')
  map('n', '<leader>di', dap.repl.toggle, '[I]nteractive REPL')
end
local reset_keys = function()
  pcall(vim.keymap.del, 'n', '<F8>')
  pcall(vim.keymap.del, 'n', '<F7>')
  pcall(vim.keymap.del, 'n', '<S-F8>')
  pcall(vim.keymap.del, 'n', '<leader>dc')
  pcall(vim.keymap.del, { 'n', 'v' }, '<leader>de')
  pcall(vim.keymap.del, 'n', '<leader>ds')
  pcall(vim.keymap.del, 'n', '<leader>du')
  pcall(vim.keymap.del, 'n', '<leader>dd')
  pcall(vim.keymap.del, 'n', '<leader>dk')
  pcall(vim.keymap.del, 'n', '<leader>di')
end
dap.listeners.after.event_terminated['me.dap.keys'] = reset_keys
dap.listeners.after.disconnect['me.dap.keys'] = reset_keys
