-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})

-- Recenter after using <C-d> and <C-u>
vim.keymap.set('n', '<C-d>', '<C-d>zz', { remap = false })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { remap = false })
