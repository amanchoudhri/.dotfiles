#!/bin/bash

# Neovim Setup Script
# This script automates the setup of neovim and related tools for fresh instances

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect architecture
detect_arch() {
    case "$(uname -m)" in
        x86_64) echo "x86_64" ;;
        aarch64|arm64) echo "aarch64" ;;
        *) echo "unknown" ;;
    esac
}

# Function to install neovim
install_neovim() {
    
    # Create ~/.local directory if it doesn't exist
    mkdir -p ~/.local/bin
    
    # Download and install neovim
    local nvim_version="v0.11.3"  # Update this as needed
    local arch=$(detect_arch)

    print_status "Installing neovim version ${nvim_version} into ${HOME}/.local/bin..."
    
    if [[ "$arch" == "x86_64" ]]; then
        local nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux64.tar.gz"
        local nvim_dir="nvim-linux64"
    elif [[ "$arch" == "aarch64" ]]; then
        local nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux-aarch64.tar.gz"
        local nvim_dir="nvim-linux-aarch64"
    else
        print_error "Unsupported architecture: $arch"
        exit 1
    fi
    
    # Download neovim
    print_status "Downloading neovim from: $nvim_url"
    curl -L -o /tmp/nvim.tar.gz "$nvim_url"
    
    # Extract and install
    cd /tmp
    tar -xzf nvim.tar.gz
    cp -r "$nvim_dir"/* ~/.local/
    
    # Add to PATH if not already there
    if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        export PATH="$HOME/.local/bin:$PATH"
    fi
    
    print_success "Neovim installed successfully"
}

# Function to install vim-plug
install_vim_plug() {
    print_status "Installing vim-plug..."
    
    # Create autoload directory
    mkdir -p ~/.local/share/nvim/site/autoload
    
    # Download plug.vim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
        --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
    print_success "vim-plug installed successfully"
}

# Function to run neovim commands
run_nvim_commands() {
    print_status "Running neovim setup commands..."
    
    if command_exists nvim; then
        # Install plugins using vim-plug
        print_status "Installing plugins with vim-plug..."
        nvim --headless -c "PlugInstall --sync" -c "qa"
        
        # Install pyright LSP with Mason
        print_status "Installing pyright LSP with Mason..."
        nvim --headless -c "MasonInstall pyright" -c "qa"
        
        print_success "Neovim plugins and pyright LSP installed successfully"
    else
        print_error "Neovim not found in PATH. Please ensure it's installed correctly."
        exit 1
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help               Show this help message"
    echo ""
    echo "This script will:"
    echo "  1. Install the latest neovim to ~/.local"
    echo "  2. Install vim-plug"
    echo "  3. Run :PlugInstall"
    echo "  4. Run :MasonInstall pyright"
}

# Main script
main() {
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    print_status "Starting neovim setup..."
    
    # Install neovim
    install_neovim
    
    # Install vim-plug
    install_vim_plug
    
    # Run neovim commands
    run_nvim_commands
    
    print_success "Setup completed successfully!"
    print_status "You can now use neovim with: ~/.local/bin/nvim"
}

# Run main function
main "$@"