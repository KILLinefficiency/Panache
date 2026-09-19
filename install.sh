#!/usr/bin/env bash

sudo pacman -S \
    fd \
	git \
	zsh \
    gcc \
	tmux \
	curl \
    tar \
    zip \
    gzip \
    unzip \
    typst \
	neovim \
    ripgrep \
    firefox \
	alacritty \
    tree-sitter \
    tree-sitter-cli \
    ttf-liberation \
	ttf-jetbrains-mono \
	ttf-jetbrains-mono-nerd \
	--noconfirm

sudo chsh -s /usr/bin/zsh $USER

# Alacritty
mkdir -p ~/.config/alacritty
cp -v ./dotfiles/alacritty.toml ~/.config/alacritty

# Tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
cp -v ./dotfiles/tmux.conf ~/.tmux.conf

# Bash
cp -v ./dotfiles/bashrc ~/.bashrc

# ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp -v ./dotfiles/zshrc ~/.zshrc

# NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.7/install.sh | bash
source $HOME/.nvm/nvm.sh
nvm install --lts

# Neovim
mkdir -p ~/.config/nvim
cp -v ./dotfiles/init.lua ~/.config/nvim/init.lua
nvim --headless +q
