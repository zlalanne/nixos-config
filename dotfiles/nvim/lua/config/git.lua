local neogit = require('neogit')
neogit.setup({})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", {desc = "Neogit"})
