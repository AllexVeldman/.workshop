-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local vmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('å', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vmap('å', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
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
require('mason-lspconfig').setup()

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure any lspconfig servers are installed automagically
require('mason-lspconfig').setup { automatic_installation = true }

-- Setup the LSP servers
-- :h lspconfig-all contains a list of all the available servers
-- the default configuration per server and where to find the full configuration options
local lspconfig = require('lspconfig')
-- Lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
}
-- Python
-- https://github.com/python-lsp/python-lsp-server
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- pylint and mypy are run by the lint plugin
lspconfig.pylsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = {
          enabled = true
        },
        autopep8 = {
          enabled = false
        },
        pycodestyle = {
          enabled = false
        },
        pyflakes = {
          enabled = true
        },
      },
    },
  }
}
-- Rust
-- https://github.com/rust-lang/rust-analyzer
-- https://rust-analyzer.github.io/manual.html#configuration
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = 'clippy',
      },
      diagnostics = {
        experimental = {
          enable = true
        }
      }
    }
  }
}
-- TypeScript
-- https://github.com/typescript-language-server/typescript-language-server
-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- CSS
-- https://github.com/microsoft/vscode-css-languageservice
lspconfig.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    css = {
      validate = true,
      format = {
        enable = true,
      },
    },
    less = {
      validate = true,
      format = {
        enable = true,
      },
    },
    scss = {
      validate = true,
      format = {
        enable = true,
      },
    },
  }
}

-- HTML
lspconfig.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- HTMX
lspconfig.htmx.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
