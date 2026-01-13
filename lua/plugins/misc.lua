return {
	-- MDX support
	{
		"davidmh/mdx.nvim",
		ft = "mdx",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	-- Competitive programming notebook
	{
		dir = "~/cp-notebook/nvim-plugin",
		cmd = "ADS",
	},

	-- Custom LSP menu
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/custom/lspmenu",
		cmd = "LspMenu",
		keys = { { "<leader>lsp", desc = "LSP Menu" } },
		config = function()
			require("lspmenu").setup()
		end,
	},

	-- Custom VimTeX menu
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/custom/vimtexmenu",
		ft = "tex",
		config = function()
			require("vimtexmenu").setup()
		end,
	},
}
