-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.DEBUG,
  -- All formatter configurations are opt-in
  filetype = {
    html = {
      require("formatter.defaults.prettier"),
    },
    javascript = {
      require("formatter.defaults.prettier"),
    },
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
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
  group = "__formatter__",
  command = ":FormatWrite",
})
