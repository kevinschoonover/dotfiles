return function()
	local nvim_treesitter = require("nvim-treesitter.configs")
	local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
	vim.fn.mkdir(parser_install_dir, "p")

	nvim_treesitter.setup({
		ensure_installed = {}, -- "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		indent = {
			enable = true,
		},
		autopairs = { enable = true },
		rainbow = { enable = true },
		autotag = { enablew = true },
		context_commentstring = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
	})
end
