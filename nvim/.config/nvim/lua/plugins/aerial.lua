-- [[ Install Aerial ]]
-- Adds the option to show a code outline for treesitter enabled languages
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
      layout = {
        default_direction = "prefer_left",
      },
      close_automatic_events = { "unsupported" },
    })
    vim.keymap.set("n", "<leader>co", aerial.toggle, { desc = "[C]ode [O]utline" })
  end
}
