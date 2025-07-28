#!/bin/bash

INSTALL_ZSH=false

# Function to display usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --with-zsh        Install zsh, oh-my-zsh, and related plugins"
    echo "  -h, --help        Display this help message"
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --with-zsh)
            INSTALL_ZSH=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

echo "Starting dotfiles setup..."

if [ "$INSTALL_ZSH" = true ]; then
    echo "Installing zsh components..."

    # install oh my zsh
    # use the unattended flag so that it doesn't run zsh after installing
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh

    # install powerlevel 10k
    echo "Installing p10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    # install zsh-autosuggestions
    echo "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # install zsh-syntax-highlighting
    echo "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # remove p10k generated ~/.zshrc file
    rm -f ~/.zshrc

else
    echo "Skipping zsh installation (use --with-zsh to enable)..."
fi

# install GNU stow into the directory
DOTFILES_DIR=$(pwd)
echo "Downloading GNU stow into ${DOTFILES_DIR}/.stow"

mkdir .stow && cd .stow \
    && wget https://ftp.gnu.org/gnu/stow/stow-2.3.1.tar.gz \
    && tar -xf stow-2.3.1.tar.gz

echo "Installing GNU stow into ${DOTFILES_DIR}/.local"
cd stow-2.3.1 \
    && ./configure --prefix=$DOTFILES_DIR/.local \
    && make install

# stow the dotfiles
echo "Stowing dotfiles"
# Stow configurations based on what was installed
if [ "$INSTALL_ZSH" = true ]; then
    .local/bin/stow git vim ssh p10k zsh aliases tmux bin
else
    # Skip zsh and p10k when not installing zsh
    .local/bin/stow git vim ssh aliases tmux bin
fi

# Only exec zsh if we installed it
if [ "$INSTALL_ZSH" = true ]; then
    exec zsh
else
    echo "Setup complete! (zsh components were skipped)"
    echo "tmux will use your current shell: $SHELL"
    echo "To install zsh components, run: $0 --with-zsh"
fi
