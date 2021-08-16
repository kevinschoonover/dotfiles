local nvim_lsp = require'lspconfig'
local on_attach = require('lsp.on_attach')
local capabilities = require('lsp.capabilities')

-- local vint = require "efm/vint"
-- local luafmt = require "efm/luafmt"
-- local golint = require "efm/golint"
-- local goimports = require "efm/goimports"
local black = {
    formatCommand = "black --fast -",
    formatStdin = true
};
-- local isort = require "efm/isort"
-- local flake8 = require "efm/flake8"
-- local mypy = require "efm/mypy"
-- local prettier = require "efm/prettier"
-- local eslint = require "efm/eslint"
-- local shellcheck = require "efm/shellcheck"
-- local shfmt = require "efm/shfmt"
-- local terraform = require "efm/terraform"
-- local misspell = require "efm/misspell"
-- https://github.com/mattn/efm-langserver
nvim_lsp.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    root_dir = vim.loop.cwd,
    filetypes = {"*"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            -- ["="] = {misspell},
            -- vim = {vint},
            -- lua = {luafmt},
            -- go = {golint, goimports},
            python = {black},--, isort, flake8, mypy},
            -- typescript = {prettier, eslint},
            -- javascript = {prettier, eslint},
            -- typescriptreact = {prettier, eslint},
            -- javascriptreact = {prettier, eslint},
            -- yaml = {prettier},
            -- json = {prettier},
            -- html = {prettier},
            -- scss = {prettier},
            -- css = {prettier},
            -- markdown = {prettier},
            -- sh = {shellcheck, shfmt},
            -- tf = {terraform}
        }
    }
}
