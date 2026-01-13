local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Filetype detection
vim.filetype.add({
	extension = {
		typ = "typst",
		sage = "python",
	},
})

-- Auto-save on leaving insert mode
autocmd({ "InsertLeave", "TextChanged" }, {
	group = augroup("AutoSave", { clear = true }),
	pattern = { "*.tex", "*.typ" },
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent! write")
		end
	end,
})

-- Set wrap, spell, and linebreak for text files
autocmd({ "FileType" }, {
	group = augroup("TextFileSettings", { clear = true }),
	pattern = { "gitcommit", "markdown", "text", "tex", "typst" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.linebreak = true
	end,
})

-- Highlight on yank
autocmd({ "TextYankPost" }, {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Auto create dir when saving a file
autocmd({ "BufWritePre" }, {
	group = augroup("AutoCreateDir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Restore cursor position
autocmd("BufReadPost", {
	group = augroup("RestoreCursor", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close some filetypes with q
autocmd("FileType", {
	group = augroup("CloseWithQ", { clear = true }),
	pattern = { "help", "lspinfo", "man", "notify", "qf", "checkhealth" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
