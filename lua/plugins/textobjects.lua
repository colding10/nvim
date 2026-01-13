return {
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
				},
				-- Silently fail if treesitter parser unavailable
				silent = true,
			}
		end,
	},
}
