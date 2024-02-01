return {
  'stevearc/aerial.nvim',
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local aerial = require("aerial")
    aerial.setup({
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        -- Uncomment this to show variables
        -- "Variable",
      },
      -- Jump to symbol in source window when the cursor moves
      autojump = true,
    })
    vim.keymap.set("n", "<leader>co", aerial.toggle, { desc = "[C]ode [O]utline" })
  end
}
