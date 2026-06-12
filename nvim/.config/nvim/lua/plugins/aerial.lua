-- [[ Install Aerial ]]
-- Adds the option to show a code outline.
-- Uses tree-sitter for tree-sitter enabled languages.
return {
  'stevearc/aerial.nvim',
  -- Optional dependencies
  dependencies = {
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
      autojump = false,
      layout = {
        default_direction = "float",
      },
      float = {
        relative = "editor",
      },
      close_automatic_events = { "unsupported" },
      close_on_select = true,
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<leader>v"] = "actions.jump_vsplit",
        ["<leader>s"] = "actions.jump_split",
        ["h"] = "actions.left",
        ["l"] = "actions.right",
        ["<Esc>"] = "actions.close",
      },
    })
    vim.keymap.set("n", "<leader>co", aerial.toggle, { desc = "[C]ode [O]utline" })
  end
}
