require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

return function()
  local lspconfig = require("lspconfig")
  local on_attach = dofile("/home/kschoon/.config/nvim/lua/modules/config/nvim-lspconfig/on-attach.lua")
  local format_config = dofile("/home/kschoon/.config/nvim/lua/modules/config/nvim-lspconfig/format.lua")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local servers = {
    efm = {
      init_options = { documentFormatting = true, codeAction = true },
      root_dir = lspconfig.util.root_pattern({ ".git/", "." }),
      filetypes = vim.tbl_keys(format_config),
      settings = { languages = format_config },
    },
    sumneko_lua = {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { keywordSnippet = "Both" },
          runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
          workspace = { library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}) },
        },
      },
    },
    rust_analyzer = {},
    pyright = {},
    tsserver = {},
    gopls = {},
    rnix = {},
    graphql = {},
  }

  -- Setup servers
  local function setup_servers()
    for server, config in pairs(servers) do
      local config = servers[server] or { root_dir = lspconfig.util.root_pattern({ ".git/", "." }) }
      config.capabilities = capabilities
      config.on_attach = on_attach
      lspconfig[server].setup(config)
    end
  end

  setup_servers()
end
