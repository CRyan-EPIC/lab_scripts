#!/bin/bash

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    echo "APT detected. Installing wget and unzip..."
    sudo apt update
    sudo apt install -y wget unzip
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install wget unzip -y
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy wget unzip
else
    echo "No supported package manager found."
    exit 1
fi

# Install OhmyPosh
curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install
oh-my-posh get shelloh-my-posh get shell

# Download the powerline theme
cd ~
mkdir .posh_themes
cd .posh_themes
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/powerline.omp.json
echo 'eval "$(oh-my-posh init bash --config ~/.posh_themes/powerline.omp.json)"' >> ~/.bashrc
