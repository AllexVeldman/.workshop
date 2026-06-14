-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local map = function(modes, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
  end
  local nmap = function(keys, func, desc)
    map('n', keys, func, desc)
  end

  local tele_builtin = require('telescope.builtin')


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  -- <Alt-a> is å on Mac
  map({ 'n', 'v' }, 'å', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map({ 'n', 'v' }, '<M-a>', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', tele_builtin.lsp_definitions, '[G]oto [D]efinition')
  -- Map over the builtin `grr` so it used telescope instead of quickfix list
  nmap('grr', tele_builtin.lsp_references, '[G]oto [R]eferences')
  nmap('gI', tele_builtin.lsp_implementations, '[G]oto [I]mplementation')
  nmap('gD', tele_builtin.lsp_type_definitions, '[G]oto Type [D]efinition')
  nmap('<leader>ws', tele_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Documentation
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- Use CTRL-S in insert and normal mode for signature help instead
  map({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Document
  nmap('<leader>ds', tele_builtin.lsp_document_symbols, '[D]ocument [s]ymbols')

  -- LSP functionality
  -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup {
  -- Disable mason from calling vim.lsp.enable() on all installed servers
  automatic_enable = false,
  ensure_installed = {}
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup the LSP servers
-- :h lspconfig-all contains a list of all the available servers
-- the default configuration per server and where to find the full configuration options
-- calls to vim.lsp.config('<name>', {<config>}) will extend the config provided by nvim-lspconfig
-- servers need to be explicitly enabled

-- Lua
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
})
vim.lsp.enable('lua_ls')

-- Python
-- https://detachhead.github.io/basedpyright
-- https://docs.basedpyright.com/#/settings
vim.lsp.config('basedpyright', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    basedpyright = { analysis = { typeCheckingMode = "standard" } }
  },
})
vim.lsp.enable('basedpyright')

-- Rust
-- https://github.com/rust-lang/rust-analyzer
-- https://rust-analyzer.github.io/manual.html#configuration
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = 'clippy',
      },
      diagnostics = {
        experimental = {
          enable = false
        }
      },
      cargo = {
        -- Use a separate target dir for rust-analyser,
        -- prevents a lock while rust_analyzer is running
        targetDir = true
      }
    }
  }
})
vim.lsp.enable('rust_analyzer')

-- TypeScript
-- https://github.com/typescript-language-server/typescript-language-server
-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('ts_ls')

-- Eslint
-- https://github.com/hrsh7th/vscode-langservers-extracted
vim.lsp.config('eslint', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('eslint')

-- CSS
-- https://github.com/microsoft/vscode-css-languageservice
vim.lsp.config('cssls', {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = { provideFormatter = false },
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  }
})
vim.lsp.enable('cssls')

-- HTML
vim.lsp.config('html', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('html')

-- CPP
-- https://clangd.llvm.org/
-- Don't forget to generate compile_commands.json
-- cmake: -DCMAKE_EXPORT_COMPILE_COMMANDS=1 then simlink it to the root of the project
-- https://clangd.llvm.org/installation#project-setup
vim.lsp.config('clangd', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('clangd')

-- YAML
-- https://github.com/redhat-developer/yaml-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
--
-- Is used by helm_ls to do schema validation on helm resources after templating
-- To define a schema for a yaml file, add `# yaml-language-server: $schema=<path to schema>`
-- to the top of the file.
--
-- https://schemastore.org is a good source of often used schemas
-- https://github.com/datreeio/CRDs-catalog is a good source of k8s CRD schemas
--
-- example:
-- # yaml-language-server: $schema=https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/gateway.networking.k8s.io/httproute_v1.json
vim.lsp.config('yamlls', {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = { enable = false },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = { "/.github/workflows/*" },
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = { "docker-compose.yml", "docker-compose.yaml" },
        ["https://www.schemastore.org/pre-commit-config.json"] = { ".pre-commit-config.yaml" },
      },
    },
  }
})
vim.lsp.enable('yamlls')

-- Helm
-- https://github.com/mrjosh/helm-ls
-- uses `yamlls` for schema validation of templated resources
vim.lsp.config('helm_ls', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('helm_ls')

-- JSON
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- extracted from: https://github.com/microsoft/vscode-json-languageservice
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
-- https://github.com/Microsoft/vscode/blob/main/extensions/json-language-features/server/README.md#settings
vim.lsp.config('jsonls', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('jsonls')

-- Terraform
-- https://github.com/hashicorp/terraform-ls
-- https://github.com/hashicorp/terraform-ls
vim.lsp.config('terraformls', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('terraformls')

-- Bash
vim.lsp.config('bashls', {
  capabilities = capabilities,
  on_attach = on_attach
})

vim.lsp.enable('bashls')

-- Sphinx
-- https://github.com/swyddfa/esbonio
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/esbonio.lua
vim.lsp.config('esbonio', {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'esbonio' },
  -- settings = {
  --   esbonio = {
  --     logging = {
  --       level = 'debug',
  --     }
  --   }
  -- }
})
-- vim.lsp.enable('esbonio')

-- Add additional pylsp dependencies
-- https://github.com/williamboman/mason.nvim/blob/main/doc/reference.md#package
-- local pylsp = require("mason-registry").get_package("python-lsp-server")
-- pylsp:on(
--   "install:success",
--   vim.schedule_wrap(function(handle)
--     print("Installing pylsp dependencies")
--     --TODO: extract this function as it is also useful in DAP setup
--     local function mason_package_path(package)
--       local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
--       return path
--     end
--
--     local path = mason_package_path("python-lsp-server")
--     local command = path .. "/venv/bin/pip"
--     local args = {
--       "install",
--       "-U",
--       "rope",
--       "pylsp-mypy",
--       "python-lsp-ruff",
--     }
--
--     require("plenary.job")
--         :new({
--           command = command,
--           args = args,
--           cwd = path,
--         })
--         :start()
--   end)
-- )
