return {
	-- VimTeX
	{
		"lervag/vimtex",
		ft = "tex",
		init = function()
			vim.g.vimtex_view_method = "general"
			vim.g.vimtex_view_general_viewer = "/Applications/Preskim.app/Contents/MacOS/Preskim"
			vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "obsolete", "Warning" }
		end,
	},

	-- Text objects for LaTeX environments
	{
		"kana/vim-textobj-user",
		ft = "tex",
	},
	{
		"rbonvall/vim-textobj-latex",
		dependencies = { "kana/vim-textobj-user" },
		ft = "tex",
	},
}
