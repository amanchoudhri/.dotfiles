vim.g.catppuccin_flavour = "frappe"
require("catppuccin").setup()
vim.cmd [[colorscheme catppuccin]]

-- Status line
require("lualine").setup({
    options = {
        icons_enabled=true,
        theme = "catppuccin"
    }
})
