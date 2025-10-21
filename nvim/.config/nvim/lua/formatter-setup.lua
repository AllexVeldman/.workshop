-- Utilities for creating configurations
local util = require "formatter.util"
local format_is_enabled = true
vim.api.nvim_create_user_command('FormatToggle', function()
  format_is_enabled = not format_is_enabled
  print('Setting formatter autoformatting to: ' .. tostring(format_is_enabled))
end, {})

local function prettier()
  return {
    exe = "npx",
    args = {
      "prettier",
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Requires prettier to be configured
    -- When using html templating, ensure you are using prettier-plugin-jinja-template
    html = { prettier },
    scss = { prettier },
    css = { prettier },
    javascript = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },

    python = {
      function()
        return {
          exe = "isort",
          args = { "-q", "--filename", util.escape_path(util.get_current_buffer_file_path()), "-" },
          stdin = true,
        }
      end,
      function()
        return {
          exe = "black",
          args = { "-q", "--stdin-filename", util.escape_path(util.get_current_buffer_file_name()), "-" },
          stdin = true,
        }
      end,
    },
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any filetype
      -- require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}


vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("__formatter__", { clear = true }),
  -- command = ":FormatWrite",
  callback = function()
    if not format_is_enabled then
      return
    end

    vim.cmd.FormatWrite()
  end,
})
