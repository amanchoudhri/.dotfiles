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
rm ~/.zshrc

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
cd $DOTFILES_DIR
.local/bin/stow git vim ssh p10k zsh aliases

# install lightline for vim
git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline

exec zsh

