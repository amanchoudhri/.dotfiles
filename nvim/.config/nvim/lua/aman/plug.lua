local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugins')

-- Themes
Plug('catppuccin/nvim', {as =  'catppuccin'})
Plug('nvim-lualine/lualine.nvim')

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})

--Autocompletion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('saadparwaiz1/cmp_luasnip')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lsp-signature-help')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/cmp-nvim-lua')

--  Snippets
Plug('L3MON4D3/LuaSnip')
Plug('rafamadriz/friendly-snippets')

-- LSP Config
Plug('neovim/nvim-lspconfig')

-- LSP Installer
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')


-- Basic LSP keybindings + settings
Plug('VonHeikemen/lsp-zero.nvim')

-- Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.0' })

-- Scrollbar
Plug('petertriho/nvim-scrollbar')

-- LaTeX plugin
Plug('lervag/vimtex')

vim.call('plug#end')
