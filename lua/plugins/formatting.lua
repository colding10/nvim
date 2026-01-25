return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = { "ConformInfo" },
		opts = {
			formatters = {
				prettier = {
					prepend_args = { "--tab-width", "4" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua", lsp_format = "prefer" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
				graphql = { "prettier" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				tex = { lsp_format = "prefer" },
				python = { "isort", "black" },
				markdown = { "mdformat" },
				typst = { "typstyle" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
