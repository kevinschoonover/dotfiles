local lsp = require("lsp-zero")

require('fidget').setup()
require('neodev').setup()
require('mason.settings').set({
  -- https://github.com/williamboman/mason.nvim/issues/428
  PATH = "append"
})

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer',
  'sumneko_lua',
})

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
