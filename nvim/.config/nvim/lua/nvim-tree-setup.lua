-- [[ Configure nvim-tree ]]
-- Adds an option to show a file tree in a sidebar
require("nvim-tree").setup {
  filters = {
    -- Show files/folder in .gitignore
    git_ignored = false,
    -- Custom list of vim regex for file/directory names that will not be shown.
    -- Backslashes must be escaped e.g. "^\\.git". See |string-match|.
    custom = {
      "^[.]git$",
      "[.]DS_Store",
      "[.]coverage$",
      "[.]coverage[.]",
      "[.]pytest_cache",
      "[.]mypy_cache",
      "[.]hypothesis",
      "__pycache__",
      "[.]idea",
    }
  },
  renderer = {
    -- Group folders with a single folder into one node.
    group_empty = true,
    -- Show the full name of a folder exceeding the width in a floating window
    full_name = true,
    -- Add indent markers to expanded folders.
    indent_markers = { enable = true },
    -- Files to highlight
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", "project.json" },
    icons = {
      show = {
        file = false,
        folder = false,
      },
    },
  },
}
local api = require("nvim-tree.api")

-- keymap to toggle the explorer
vim.keymap.set('n', '<leader>f',
  function()
    api.tree.toggle({ find_file = true })
  end,
  { desc = '[F]ile Explorer' }
)
