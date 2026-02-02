return {
	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		lazy = true,
		config = function()
			local ls = require("luasnip")
			local snippets_path = vim.g.lua_snippets_path or (vim.fn.stdpath("config") .. "/lua/snippets")

			require("luasnip.loaders.from_lua").load({ paths = snippets_path })

			ls.setup({
				history = true,
				updateevents = "TextChangedI",
				enable_autosnippets = true,
			})
		end,
	},

	-- LSP kind icons
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},

	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
"FelipeLema/cmp-async-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")
			local lspkind = require("lspkind")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
						scrollbar = false,
					},
					documentation = {
						border = "rounded",
						winhighlight = "Normal:CmpDoc",
					},
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({ mode = "symbol", maxwidth = 50 })(entry, vim_item)
						kind.kind = (kind.kind or "") .. " "
						return kind
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						elseif cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if ls.jumpable(-1) then
							ls.jump(-1)
						elseif cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
		{ name = "async_path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
