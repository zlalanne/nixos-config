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
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }
    },
    w = {
        name = "windows",
        h = { "<C-w>h", "Move to left window" },
        l = { "<C-w>l", "Move to right window" },
        j = { "<C-w>j", "Move to window below" },
        k = { "<C-w>k", "Move to window above" },
        d = { "<C-w>c", "Delete window" },
        w = { "<C-w>p", "Other window" }
    },
    a = {
        name = "applications",
        u = { "<cmd>UndotreeToggle<cr>", "UndoTree" },
        v = { "<cmd>VimBeGood<cr>", "VimBeGood" }
    },
    p = {
        name = "project",
        f = { "<cmd>Telescope git_files<cr>", "Project files" }
    },
    g = {
        name = "git",
        s = { "<cmd>Git<cr>", "git status" },
        p = { "<cmd>Git push<cr>", "git push" }
    },
    b = {
        name = "+buffers"
    },
    x = {
        name = "+diagnostics"
    },
}, { prefix = "<leader>" })

-- Some keybindings for special characters are easier to bind this way
wk.register({
    ["<leader><Tab>"] = { "<C-6>", "Last Buffer" },
    ["<leader>w|"] = { "<cmd>vsplit<cr>", "Split vertically" },
    ["<leader>w-"] = { "<cmd>split<cr>", "Split horizontally" }
})
