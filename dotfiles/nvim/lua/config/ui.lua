-- Icons
require("nvim-web-devicons").setup()

-- Status line
require('lualine').setup({
    options = {
        theme = "tokyonight",
    },
    sections = {
        lualine_b = {
            {
                "diff",
                colored = true,
            }
        }
    }
})
