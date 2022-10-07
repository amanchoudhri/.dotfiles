require 'nvim-treesitter'.setup {}
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python" },
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "latex" }
    },
    indent = {
        enable = true,
        disable = { "python" }
    }
}


local lsp = require('lsp-zero')

-- Setup everything except nvim-cmp
lsp.preset('lsp-compe')

-- Recommended sumneko lua config. See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
-- For more information.

lsp.configure('sumneko_lua', { settings = {
    Lua = {
        runtime = {
            version = 'LuaJIT',
        },
        diagnostics = {
            globals = {'vim'},
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
            enable = false,
        },
    },
}})

lsp.setup()

