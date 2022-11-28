vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Don't wrap text that's too long
vim.opt.wrap = false

vim.opt.termguicolors = true

-- Intuitive splits
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"

-- Config stolen from theprimeagen
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Case insensitive search unless caps are used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Get rid of swapfile stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
