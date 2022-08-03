# install oh my zsh
# use the unattended flag so that it doesn't run zsh after installing
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

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
mkdir .stow && cd .stow
wget https://ftp.gnu.org/gnu/stow/stow-2.3.1.tar.gz
tar -xf stow-2.3.1.tar.gz
cd stow-2.3.1
echo "Installing GNU stow into ${DOTFILES_DIR}/.local"
./configure --prefix=$DOTFILES_DIR/.local
make install

# stow the dotfiles
echo "Stowing dotfiles"
cd $DOTFILES_DIR
.local/bin/stow git vim ssh p10k zsh

exec zsh

