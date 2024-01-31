-- List all installed plugins
local list_plugins = function()
  local M = require('lazy')
  local plugins = {}
  for _, v in pairs(M.plugins()) do
    table.insert(plugins, v[1])
  end
  return plugins
end
vim.api.nvim_create_user_command('ListPlugins', function() vim.print(list_plugins()) end, {})

-- Query GitHub API for security advisories for a given repo
local get_advisories = function(repo)
  vim.print(repo)
  local output = vim.fn.system({
    "curl",
    "-L",
    "-s",
    "-S",
    "-H", "Accept: application/vnd.github+json",
    "-H", "Authorization: Bearer " .. vim.env.GH_TOKEN,
    "-H",
    "X-GitHub-Api-Version: 2022-11-28",
    "https://api.github.com/repos/" .. repo .. "/security-advisories",
  })
  local result = vim.json.decode(output)
  if next(result) ~= nil then vim.print(result) end
end

-- Query GitHub API for security advisories for all installed plugins
vim.api.nvim_create_user_command(
  "ScanLazyDeps",
  function()
    local plugins = list_plugins()
    for _, v in pairs(plugins) do
      get_advisories(v)
    end
  end
  , {})
-- curl -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/nvim-neotest/neotest/security-advisories
