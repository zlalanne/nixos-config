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
