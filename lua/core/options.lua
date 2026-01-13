local o = vim.o
local opt = vim.opt

-- Clipboard (empty to avoid default clipboard behavior)
opt.clipboard = ""

-- Indentation
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

-- UI
o.showmode = false
o.showcmd = true
o.termguicolors = true
o.number = true
o.relativenumber = true
o.cursorline = false
o.signcolumn = "yes"
o.scrolloff = 8
o.sidescrolloff = 8

-- Behavior
o.swapfile = false
o.writebackup = false
o.updatetime = 30
o.jumpoptions = "view"
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true
o.virtualedit = "block"
o.smoothscroll = true

-- Mouse
o.mouse = "a"

-- Undo
o.undofile = true

-- Snippets path
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"
