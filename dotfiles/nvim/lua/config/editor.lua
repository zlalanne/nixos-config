-- Better diagnostics list
require("trouble").setup({
  use_diagnostic_signs = true,
})

vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>TroubleToggle document_diagnostics<cr>",
  { desc = "Document Diagnostics (Trouble)" }
)
vim.keymap.set(
  "n",
  "<leader>xX",
  "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { desc = "Workspace Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List (Trouble)" })

-- Gutter gitsigns
require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
})

-- Better buffer deletion, keep window layout when closing a buffer
local bufremove = require("mini.bufremove")

bufremove.setup({})
vim.keymap.set("n", "<leader>bd", function()
  bufremove.delete(0, false)
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", function()
  bufremove.delete(0, true)
end, { desc = "Delete Buffer (Force)" })

-- Flash setup
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set({ "o" }, "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set({ "c" }, "<C-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>ah", function() harpoon:list():append() end, { desc = "Harpoon" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-j>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-k>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-l>", function()
  harpoon:list():select(4)
end)

-- Undotree
vim.keymap.set("n", "<leader>au", "<cmd>UndotreeToggle<cr>", { desc = "Undotree" })

-- VimBeGood
vim.keymap.set("n", "<leader>av", "<cmd>VimBeGood<cr>", { desc = "VimBeGood" })
