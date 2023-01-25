local lsp = require("lsp-zero")

require('fidget').setup()
require('neodev').setup()
require('mason.settings').set({
  -- https://github.com/williamboman/mason.nvim/issues/428
  PATH = "append"
})

lsp.preset("recommended")

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- Pass arguments to a language server
lsp.configure('jsonls', {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  }
})

lsp.configure('yamlls', {
  settings = {
    yaml = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  }
})

lsp.configure('gopls', {
  settings = {
    gopls = {
      staticcheck = true
    },
  }
})

lsp.configure('rust_analyzer', {
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
})

lsp.on_attach(function(client, _)
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup Format
        au! * <buffer>
        au BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
    ]])
  end

  -- So that the only client with format capabilities is efm
  -- if client.name ~= "gopls" and client.name ~= "go" and client.name ~= "efm" and client.name ~= "rnix" then
  -- 	client.server_capabilities.documentFormattingProvider = false
  -- end

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options('null-ls', {})
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local hclfmt = h.make_builtin({
  name = "hclfmt",
  meta = {
    url = "https://pkg.go.dev/github.com/hashicorp/hcl/v2@v2.15.0/cmd/hclfmt",
    description = "The hclfmt command rewrites `hcl` configuration files to a canonical format and style.",
  },
  method = methods.internal.FORMATTING,
  filetypes = { "hcl" },
  generator_opts = {
    command = "hclfmt",
    to_stdin = true,
  },
  factory = h.formatter_factory,
})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    hclfmt,
    null_ls.builtins.formatting.packer,
    null_ls.builtins.formatting.black,
  },
})
