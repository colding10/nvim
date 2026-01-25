local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "Command mode" })
map("i", "jk", "<ESC>")
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- Save & Quit
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>wqa!<CR>", { desc = "Save and quit all" })

-- System clipboard
map({ "n", "v" }, "d", '"+d', { silent = true })
map({ "n", "v" }, "y", '"+y', { silent = true })
map({ "n", "v" }, "x", '"+d', { silent = true })
map({ "n", "v" }, "p", '"+p', { silent = true })
map({ "n", "v" }, "P", '"+P', { silent = true })

-- Buffers
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Format
map("n", "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

-- Line navigation
map({ "n", "x" }, "H", "^", { desc = "Start of line" })
map({ "n", "x" }, "L", "g_", { desc = "End of line" })

-- Copy entire buffer
map("n", "<leader>y", "<cmd>%yank+<CR>", { desc = "Copy entire buffer" })

-- Undo breakpoints
for _, ch in ipairs({ ",", ".", "!", "?", ":" }) do
	map("i", ch, ch .. "<C-g>u")
end

-- Snippet jump
map({ "i", "s" }, "<C-l>", function()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- ADS (competitive programming)
map("n", "<leader>ads", "<cmd>ADS<CR>")
