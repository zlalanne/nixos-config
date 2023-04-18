vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Clear search with <esc>
vim.keymap.set({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
