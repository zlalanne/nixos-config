
-- Relative line numbers
vim.opt.relativenumber = true
vim.opt.nu = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indention
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Swap/backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50

-- Searches
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- 80 char column
vim.opt.colorcolumn = "80"

-- Extra keybindings
vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
