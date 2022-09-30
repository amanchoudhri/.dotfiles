vim.g.tex_flavor = 'latex';
vim.g.vimtex_compiler_latexmk = {build_dir = 'aux'};
if vim.api.nvim_eval("has('macunix')") then
    vim.g.vimtex_view_method = 'skim'
end
