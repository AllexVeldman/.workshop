require("nvim-tree").setup {}
local api = require("nvim-tree.api")

-- keymap to toggle the explorer
vim.keymap.set('n', '<leader>f',
  function()
    api.tree.toggle({ find_file = true })
  end,
  { desc = '[F]ile Explorer' }
)
