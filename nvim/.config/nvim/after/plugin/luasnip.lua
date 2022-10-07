local ls = require('luasnip')

require('luasnip-latex-snippets').setup()

ls.config.set_config({
    history = true,
    updateevents = 'TextChanged, TextChangedI',
    enable_autosnippets = true,
})

-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
-- via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
vim.keymap.set(
    {'i', 's'},
    '<Tab>',
    function()
        if ls.expand_or_jumpable() then
            return '<Plug>luasnip-expand-or-jump'
        end
    end, { remap = true, expr = true, silent = true }
)
-- -1 for jumping backwards.
vim.keymap.set(
    {'i', 's'},
    '<S-Tab>',
    function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end, { silent = true }
)

-- expand snippet or jump forwards 
-- vim.keymap.set({'i', 's'}, '<c-k>', function()
--     if ls.expand_or_jumpable() then
--         ls.expand_or_jump()
--     end
-- end, { silent = true })
-- 
-- -- if I can jump back, do so
-- vim.keymap.set({ "i", "s" }, "<c-j>", function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })
-- 
-- -- <c-l> is selecting within a list of options.
-- -- This is useful for choice nodes (introduced in the forthcoming episode 2)
-- vim.keymap.set("i", "<c-l>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

local snippet = ls.s
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node

ls.add_snippets("tex", {
    -- use mk to create an inline math environment
    snippet("mk", {
        t("$"),
        i(1),
        t("$ "),
        i(0)
    }),
    -- use equ to start an equation environment
    snippet("eqn", {
        t({"\\begin{equation}", ""}),
        i(1),
        t({"", "\\label{eq:"}), i(2), t("}"),
        t({"", "\\end{equation}", ""}), i(0)
    })
}, {type = "autosnippets"})
