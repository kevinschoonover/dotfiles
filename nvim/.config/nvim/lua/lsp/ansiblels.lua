local on_attach = require('lsp.on_attach')
local capabilities = require('lsp.capabilities')

require('lspconfig').ansiblels.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ansible = {
        ansibleLint = {
          arguments = ""
        },
      }
    }
}
