
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Use setup defaults with spelling enabled
require("which-key").setup {
  plugins = {
    spelling = {
      enabled = true
    }
  }
}

local wk = require("which-key")

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File"}
  },
  w = {
    name = "windows",
    h = { "<C-w>h", "Move to left window"},
    l = { "<C-w>l", "Move to right window"},
    j = { "<C-w>j", "Move to window below"},
    k = { "<C-w>k", "Move to window above"},
    v = { "<cmd>vsplit<cr>", "Split vertically"},
    s = { "<cmd>split<cr>", "Split horizontally"},
    d = { "<cmd>q<cr>", "Close the window"}
  },
  a = {
    name = "applications",
    u = { "<cmd>UndotreeToggle<cr>", "UndoTree" }
  },
  p = {
    name = "project",
    f = { "<cmd>Telescope git_files<cr>", "Project files" }
  }
}, { prefix = "<leader>"})
