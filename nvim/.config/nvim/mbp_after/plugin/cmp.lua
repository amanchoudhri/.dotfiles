-- Set up nvim-cmp.
local cmp = require('cmp')
if not cmp then return end

-- lsp.setup_nvim_cmp({
--     sources = {
--         {name = 'path'},
--         {name = 'nvim_lsp', keyword_length = 2},
--         {name = 'nvim_lsp_signature_help'},
--         {name = 'buffer', keyword_length = 3}
--     },
--     mapping = {
--         ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     }
-- })
local base_mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-J>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
    ['<C-K>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'})
}

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    -- Copy nvim lsp-zero formatting cuz i'm used to it lol
    formatting = {
        fields = {'abbr', 'menu', 'kind'},
        format = function(entry, item)
          local short_name = {
            nvim_lsp = 'LSP',
            nvim_lua = 'nvim'
          }

          local menu_name = short_name[entry.source.name] or entry.source.name

          item.menu = string.format('[%s]', menu_name)
          return item
        end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert(base_mapping),
    sources = cmp.config.sources({
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 2},
        {name = 'nvim_lsp_signature_help', keyword_length=1},
        {name = 'buffer', keyword_length = 3}
    })
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.insert(base_mapping),
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.insert(base_mapping),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})

