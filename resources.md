# resources

Resources that I've found helpful when configuring tmux/nvim etc on new servers.

## Nvim quickstart
1. Install `vim-plug`, using the instructions [here](https://github.com/junegunn/vim-plug). It involves putting a `plug.vim` file into the nvim "autoload" directory. On nvim startup, run `:PlugInstall`.

2. Add Mason LSP servers. As of Jul 28, 2025, some that I use are: `clangd`, `html-lsp`, `json-lsp`, `lua-language-server`, `markdownlint`, `pyright`, `texlab`, `typescript-language-server`, `vim-language-server`, and `yaml-language-server`.



## If the `glibc` version is not found or too old

Try an "unsuppoorted" neovim release version from https://github.com/neovim/neovim-releases.

## If `nvim` colors aren't displaying correctly in `tmux` through `ssh`

Configuration to add to `.tmux.conf`

```
set -ag terminal-overrides ",xterm-256color:Tc"
set -g default-terminal screen-256color
```

### Check tmux version, install locally if out of date.
Install guide: https://github.com/tmux/tmux/wiki/Installing.

If installing `libevent` and `ncurses` locally, use the following code block
to configure and install `tmux`.

```bash
tar -zxf tmux-*.tar.gz
cd tmux-*/
PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig ./configure --prefix=$HOME/local
make && make install
```

