return {
	-- Lazydev (better Lua LSP for nvim config)
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Mason for LSP/tool installation
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Mason-lspconfig bridge
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"ts_ls",
				"pyright",
				"clangd",
				"rust_analyzer",
				"texlab",
				"ltex",
				"marksman",
				"zls",
				"astro",
				"tinymist",
			},
			automatic_installation = true,
		},
	},

	-- Mason tool installer for formatters/linters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"black",
				"isort",
				"clang-format",
			},
		},
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Ensure mason and mason-lspconfig are loaded first
			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Diagnostic config
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})

			-- LSP keymaps on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				end,
			})

			-- Server configurations
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				ts_ls = {},
				html = {},
				cssls = {},
				pyright = {},
				clangd = {},
				rust_analyzer = {},
				marksman = {},
				zls = {},
				astro = {},
				texlab = {
					settings = {
						texlab = {
							build = {
								executable = "latexmk",
								args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
								onSave = true,
							},
						},
					},
				},
				ltex = {
					settings = {
						ltex = {
							language = "en-US",
						},
					},
				},
				tinymist = {
					filetypes = { "typst" },
					settings = {
						exportPdf = "onSave",
						outputPath = "$root/$dir/$name",
					},
				},
			}

			-- Configure and enable each server
			for server, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(server, config)
			end

			-- Enable all servers
			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
}
