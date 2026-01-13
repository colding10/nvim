return {
	-- Typst preview
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		build = function()
			require("typst-preview").update()
		end,
		opts = {},
	},

	-- Note: Tinymist LSP is configured in lua/plugins/lsp.lua
}
