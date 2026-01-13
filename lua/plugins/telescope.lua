return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
			{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in buffer" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
			{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
			{ "<leader>f:", "<cmd>Telescope command_history<CR>", desc = "Command history" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					selection_caret = " ",
					entry_prefix = " ",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						width = 0.87,
						height = 0.80,
					},
					file_ignore_patterns = { "node_modules", ".git/", "%.lock" },
					path_display = { "truncate" },
					mappings = {
						n = { ["q"] = require("telescope.actions").close },
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			telescope.load_extension("fzf")
		end,
	},

	-- Plenary (dependency)
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
}
