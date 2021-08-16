require('lsp.autocomplete')
require('lsp.ansiblels')
require('lsp.efm')
require('cmp_nvim_lsp').setup {}

local on_attach = require('lsp.on_attach')
local capabilities = require('lsp.capabilities')
local nvim_lsp = require'lspconfig'

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'terraformls', 'tailwindcss', 'jsonls', 'html', 'graphql', 'gopls', 'dockerls', 'cssls', 'bashls', 'vimls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end
