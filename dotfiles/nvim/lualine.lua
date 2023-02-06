
require('lualine').setup({
    options = {
        theme = "solarized_dark",
    },
    sections = {
        lualine_b = {
            {
                "diff",
                colored = false,
            }
        }
    }
})
