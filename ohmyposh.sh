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

# Add ~/.local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install OhmyPosh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Ensure installation worked
if ! command -v oh-my-posh >/dev/null 2>&1; then
    echo "❌ Oh My Posh not found after installation."
    exit 1
fi

# Install fonts (optional)
oh-my-posh font install

# Download powerline theme
mkdir -p ~/.posh_themes
cd ~/.posh_themes
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/powerline.omp.json

# Add init line to .bashrc if not already present
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(oh-my-posh init bash --config ~/.posh_themes/powerline.omp.json)"' >> ~/.bashrc
source ~/.bashrc
