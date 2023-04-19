require("nvim-treesitter.configs").setup({
    auto_install = false, -- Parsers are managed by Nix
    highlight = {
        enable = true,
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<nop>",
            node_decremental = "<bs>",
        },
    },
})
