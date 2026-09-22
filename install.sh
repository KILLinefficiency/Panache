#!/usr/bin/env bash

sudo pacman -S \
    fd \
	git \
    gcc \
	tmux \
	curl \
    tar \
    zip \
    gzip \
    unzip \
    typst \
    bluez \
	neovim \
    blueman \
    ripgrep \
    firefox \
	alacritty \
    base-devel \
    bluez-utils \
    tree-sitter \
    tree-sitter-cli \
    ttf-liberation \
	ttf-jetbrains-mono \
	ttf-jetbrains-mono-nerd \
	--noconfirm

sudo systemctl enable --now bluetooth

# Alacritty
mkdir -p ~/.config/alacritty
cp -v ./dotfiles/alacritty.toml ~/.config/alacritty

# Tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
cp -v ./dotfiles/tmux.conf ~/.tmux.conf

# Bash
cp -v ./dotfiles/bashrc ~/.bashrc

# NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.7/install.sh | bash
source $HOME/.nvm/nvm.sh
nvm install --lts

# Neovim
mkdir -p ~/.config/nvim
cp -v ./dotfiles/init.lua ~/.config/nvim/init.lua
nvim --headless +q
