local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup Format
        au! * <buffer>
        au BufWritePre <buffer> lua vim.lsp.buf.format { timeout_ms = 5000 }
      augroup END
    ]])
  end

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

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

vim.filetype.add {
  pattern = {
    ['openapi.*%.ya?ml'] = 'yaml.openapi',
    ['openapi.*%.json'] = 'json.openapi',
  },
}

require('fidget').setup({})
require('neodev').setup()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local lsps = {
  { "lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          -- checkThirdParty = "Disable",
          checkThirdParty = false,
        }
      }
    }
  } },
  { "jsonls", {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    }
  } },
  { "yamlls", {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      yaml = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    }
  } },
  { "gopls", {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      gopls = {
        semanticTokens = true,
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        gofumpt = true,
      },
    }
  } },
  { "rust_analyzer", {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            'cargo', 'clippy', '--workspace', '--message-format=json',
            '--all-targets', '--all-features'
          }
        }
      }
    }
  } },
  { "ts_ls", {
    on_attach = on_attach,
    capabilities = capabilities,

  } },
  { "bashls", {
    on_attach = on_attach,
    capabilities = capabilities,

  } },
  { "nil_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
  } },
  { "marksman", {
    on_attach = on_attach,
    capabilities = capabilities,
  } },
  { "cmake", {
    on_attach = on_attach,
    capabilities = capabilities,
  } },
  { "ccls", {
    on_attach = on_attach,
    capabilities = capabilities,
  } },
  { "vacuum", {
    on_attach = on_attach,
    capabilities = capabilities,
  } },
  {
    "golangci_lint_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
  } },
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  if config then
    vim.lsp.config(name, config)
  end
end

vim.diagnostic.config({
  virtual_text = true
})

vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local null_ls = require("null-ls")

null_ls.setup({
  on_attach = on_attach,
  sources = {
    require("none-ls.diagnostics.eslint_d"),
    require("none-ls.formatting.eslint_d"),
    require("none-ls.code_actions.eslint_d"),
  },
})
