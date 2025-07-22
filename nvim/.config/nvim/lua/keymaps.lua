-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
local wk = require('which-key')
wk.add({ mode = { 'n', 'v' }, '<Space>', '<Nop>', silent = true })

-- Remap for dealing with word wrap
wk.add({
  { 'k', "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true },
  { 'j', "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true },
})

-- Swap the xclipboard and the unnamed register
wk.add({
  {
    '"\'',
    function()
      local unnamed = vim.fn.getreg('"')
      local xclip = vim.fn.getreg('+')
      vim.fn.setreg('+', unnamed)
      vim.fn.setreg('"', xclip)
    end,
    desc = 'Swap clipboard and unnamed register'
  },
})



-- Keymaps so move-line works
wk.add({
  {
    mode = 'n',
    {
      -- MacOS
      { '˚', ":m .-2<CR>==", desc = 'Move line up' },
      { '∆', ":m .+1<CR>==", desc = 'Move line down' },
      -- Linux
      { '<A-k>', ":m .-2<CR>==", desc = 'Move line up' },
      { '<A-j>', ":m .+1<CR>==", desc = 'Move line down' },
    }
  },
  {
    mode = 'v',
    {
      -- MacOS
      { "˚", ":m '<-2<CR>gv=gv", desc = 'Move line up' },
      { "∆", ":m '>+1<CR>gv=gv", desc = 'Move line down' },
      -- Linux
      { "<A-k>", ":m '<-2<CR>gv=gv", desc = 'Move line up' },
      { "<A-j>", ":m '>+1<CR>gv=gv", desc = 'Move line down' },
    }
  }
})

-- document existing key chains
require('which-key').add(
  {
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "LSP: [D]ocument, DAP: [D]ebug" },
    { "<leader>g", group = "[G]it" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>w", group = "LSP: [W]orkspace" },
    { "<leader>b", group = "[B]reakpoint" },
  }
)
