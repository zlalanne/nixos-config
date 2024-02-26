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

local rainbow_delimiters = require("rainbow-delimiters")
require("rainbow-delimiters.setup").setup({
  strategy = {
    [""] = rainbow_delimiters.strategy["global"],
  },
  query = {
    [""] = "rainbow-delimiters",
  },
  priority = {
    [""] = 110,
  },
})
