-- [[ Configure Tree-sitter ]]
-- Parses code to ASTs to language aware features to other plugins.
--
-- Can also provide syntax highlighting by running `vim.treesitter.start()`
--
-- To (re)build all parsers, run `:TSInstall`.
--
-- neovim provides these parsers builtin:
-- - C
-- - Lua
-- - Markdown
-- - Vimscript
-- - Vimdoc

local fs = vim.fs
local fn = vim.fn
local nio = require('nio')

-- require('nvim-treesitter').install({
--   'cpp',
--   'go',
--   'tsx',
--   'typescript',
--   'toml',
--   'graphql',
--   'yaml',
-- })


---Resolve a notify function
---
---Uses fidget.notify if available.
---Falls back to vim.notify if not.
local function find_notify()
  local ok, fidget = pcall(require, 'fidget')
  if ok then
    return fidget.notify
  else
    return vim.notify
  end
end

local _notify = find_notify()

---Show a notification to the user, with a default annotation
local function notify(msg, level, opts)
  local default_opts = { annote = "TSInstall" }
  for k, v in pairs(opts) do default_opts[k] = v end
  _notify(msg, level, default_opts)
end

---@class TSParserConf
---@field name string Name of the parser
---@field repo string Git repo of the parser
---@field version string Version or branch to checkout
---@field enable boolean Add and start the parser for its filetype(s). Make sure you have the queries for it.


---List of tree-sitter parsers to install when running `:TSInstall`
---@type TSParserConf[]
local parsers = {
  {
    name = 'rust',
    repo = 'https://github.com/tree-sitter/tree-sitter-rust.git',
    version = 'v0.24.2',
    enable = true,
  },
  {
    name = 'python',
    repo = 'https://github.com/tree-sitter/tree-sitter-python.git',
    version = 'v0.25.0',
    enable = true,
  },
  {
    name = 'cpp',
    repo = 'https://github.com/tree-sitter/tree-sitter-cpp.git',
    version = 'v0.23.4',
    enable = true,
  },
  {
    name = 'javascript',
    repo = 'https://github.com/tree-sitter/tree-sitter-javascript.git',
    version = 'v0.25.0',
    enable = false,
  },
  -- {
  --   name = 'typescript',
  --   repo = 'https://github.com/tree-sitter/tree-sitter-typescript.git',
  --   version = 'v0.23.2',
  --   enable = false,
  -- },
  {
    name = 'bash',
    repo = 'https://github.com/tree-sitter/tree-sitter-bash.git',
    version = 'v0.25.1',
    enable = true,
  },
  {
    name = 'json',
    repo = 'https://github.com/tree-sitter/tree-sitter-json.git',
    version = 'v0.24.8',
    enable = false,
  },
  {
    name = 'html',
    repo = 'https://github.com/tree-sitter/tree-sitter-html.git',
    version = 'v0.23.2',
    enable = true,
  },
}


---Build the given parser into
---
---Result is written to `$XDG_DATA_HOME/nvim/site/parser/<parser name>.so`
---`$XDG_DATA_HOME` defaults to `$HOME/.local/share`
---
---ref:
--- - https://wiki.archlinux.org/title/XDG_Base_Directory
--- - https://tree-sitter.github.io/tree-sitter/cli/build.html
---
---@async
---@param parser_conf TSParserConf Config of the parser to build
---@param src_dir string Location of the source to build
local function build_parser(parser_conf, src_dir)
  notify("Building " .. parser_conf.name, nil, { key = parser_conf.name })

  local xdg_home = os.getenv('XDG_DATA_HOME') or os.getenv('HOME') .. '/.local/share'
  local out_dir = xdg_home .. "/nvim/site/parser/" .. parser_conf.name .. ".so"

  -- Build the parser
  local process = nio.process.run({
    cmd =
    'tree-sitter',
    args = {
      'build',
      '-o', out_dir,
      src_dir,
    }
  })

  -- Check build result
  if process.result(false) ~= 0 then
    notify("failed to build " .. src_dir, vim.log.levels.ERROR, { key = parser_conf.name })
    vim.print(process.stderr.read())
  end

  process.close()
end

---Download the parser source
---@async
---@param parser_conf TSParserConf Config of the parser to download
---@param cache_dir string Location to download the repo to
---@return string? src_dir Checkout directory
local function download(parser_conf, cache_dir)
  notify("Downloading " .. parser_conf.name, nil, { key = parser_conf.name })

  ---@type string?
  local checkout_dir = cache_dir .. '/tree-sitter-' .. parser_conf.name

  -- Checkout the source directory
  local process = nio.process.run({
    cmd = 'git',
    args = {
      'clone',
      '-c', 'advice.detachedHead=false',
      '--depth', '1',
      '--branch', parser_conf.version,
      parser_conf.repo,
      checkout_dir,
    }
  })

  -- Check process result
  if process.result(false) ~= 0 then
    notify("failed to download " .. parser_conf.repo, vim.log.levels.ERROR, { key = parser_conf.name })
    vim.print(process.stderr.read())
    checkout_dir = nil
  end
  process.close()
  return checkout_dir
end


---Install all defined parsers
---@async
local function ts_install()
  local cache_dir = fs.normalize(fn.stdpath('cache')) .. "/tree-sitter-parsers"

  -- Clear the cache dir so we always rebuild a clean download
  fs.rm(cache_dir, { recursive = true, force = true })

  -- Build a list of functions to run in parallel
  local fns = {}
  for _, parser in pairs(parsers) do
    table.insert(fns,
      function()
        local src_dir = download(parser, cache_dir)
        if src_dir then
          build_parser(parser, src_dir)
        end
        notify(parser.name .. ' Done', nil, { key = parser.name })
      end)
  end

  -- Run all build in parallel
  nio.gather(fns)

  fs.rm(cache_dir, { recursive = true, force = true })
end


-- User command to build and install tree-sitter parsers
vim.api.nvim_create_user_command('TSInstall', function() nio.run(ts_install) end, {})

---Start a parser
---@param parser_conf TSParserConf Parser to start
local function ts_start(parser_conf)
  if parser_conf.enable then
    vim.api.nvim_create_autocmd('FileType', {
      pattern = parser_conf.name,
      callback = function(ev)
        vim.treesitter.start(ev.buf, parser_conf.name)
        -- vim.bo[ev.buf].syntax = 'ON' -- only if additional legacy syntax is needed
      end
    })
  end
end

for _, parser in pairs(parsers) do
  ts_start(parser)
end
