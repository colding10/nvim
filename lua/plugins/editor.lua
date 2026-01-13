return {
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			local cond = require("nvim-autopairs.conds")

			-- LaTeX pairs
			npairs.add_rule(Rule("\\left(", "\\right)", "tex"))
			npairs.add_rule(Rule("\\left[", "\\right]", "tex"))
			npairs.add_rule(Rule("\\left{", "\\right}", "tex"))
			npairs.add_rule(Rule("\\left|", "\\right|", "tex"))
			npairs.add_rule(Rule("{", "}", "tex"))
			npairs.add_rule(Rule("(", ")", "tex"))

			-- LaTeX math $ pair
			npairs.add_rules({
				Rule("$", "$", { "tex", "latex" })
					:with_pair(cond.not_before_text("$"))
					:with_pair(cond.not_after_regex("%%"))
					:with_move(cond.not_after_text("$")),
			})

			-- CMP integration
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		opts = {},
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "󰍵" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { buffer = bufnr, expr = true })

				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { buffer = bufnr, expr = true })

				vim.keymap.set("n", "<leader>gs", gs.stage_hunk, opts)
				vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts)
				vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts)
				vim.keymap.set("n", "<leader>gb", gs.blame_line, opts)
			end,
		},
	},

	-- Flash (quick navigation)
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{
				"<leader>Ss",
				function()
					require("persistence").load()
				end,
				desc = "Restore session",
			},
			{
				"<leader>Sl",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore last session",
			},
			{
				"<leader>Sd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't save session",
			},
		},
	},
}
