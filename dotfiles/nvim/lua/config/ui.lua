-- Icons
require("nvim-web-devicons").setup()

-- Theme
vim.opt.termguicolors = true
vim.cmd('colorscheme tokyonight-night')

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
