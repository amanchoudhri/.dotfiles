vim.g.catppuccin_flavour = "frappe"
require("catppuccin").setup()
vim.cmd [[colorscheme catppuccin]]

-- Status line
require("lualine").setup({
    options = {
        theme = "catppuccin"
    }
})
