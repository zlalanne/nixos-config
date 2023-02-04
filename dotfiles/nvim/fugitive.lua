
local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  desc = "Remap some bindings when in fugitive status",
  pattern = {"FugitiveIndex", "FugitiveObject"},
  callback = function(ev)
    vim.keymap.set("n", "<Tab>", "=", {buffer = true, remap=true})
    vim.keymap.set("n", "q", "<cmd>q<cr>", {buffer = true})
    vim.keymap.set("n", "p", "<cmd>Git push<cr>", {buffer = true, remap=true})
  end
})
