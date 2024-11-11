# resources

Resources that I've found helpful when configuring tmux/nvim etc on new servers.

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

