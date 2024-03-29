-- Use setup defaults with spelling enabled
require("which-key").setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  defaults = {
    mode = { "n", "v" },
    ["g"] = { name = "+goto" },
    ["gz"] = { name = "+surround" },
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["<leader><tab>"] = { name = "+tabs" },
    ["<leader>b"] = { name = "+buffer" },
    ["<leader>c"] = { name = "+code" },
    ["<leader>f"] = { name = "+file/find" },
    ["<leader>g"] = { name = "+git" },
    ["<leader>q"] = { name = "+quit/session" },
    ["<leader>s"] = { name = "+search" },
    ["<leader>u"] = { name = "+ui" },
    ["<leader>w"] = { name = "+windows" },
    ["<leader>x"] = { name = "+diagnostics/quickfix" },
    ["<leader>r"] = { name = "+references" },
  },
})

local wk = require("which-key")

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  },
  p = {
    name = "project",
    f = { "<cmd>Telescope git_files<cr>", "Project files" },
  },
}, { prefix = "<leader>" })
