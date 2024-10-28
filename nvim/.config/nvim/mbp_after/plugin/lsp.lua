require('nvim-treesitter').setup({})
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "lua", "c" },
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

local lsp_attach = function(client, bufnr)
    lsp.default_keymaps({buffer=bufnr})
end

lsp.extend_lspconfig({
    capabilities=require('cmp_nvim_lsp').default_capabilities(),
    lsp_attach=lsp_attach,
    float_border='rounded',
    sign_text=true,
})

-- Recommended sumneko lua config. See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
-- For more information.

lsp.configure('lua_ls', { settings = {
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

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})
