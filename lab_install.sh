#!/bin/bash

#install these programs
sudo apt update
sudo apt install snapd openssh openvpn blender krita godot3 gimp \
  chromium-browser virtualbox* gcc top htop docker.io vim neovim nano \
  gns3-* gcc g++ make lolcat fortune gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap -y

#flatpak update
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#install Fedora media writer
flatpak install flathub org.fedoraproject.MediaWriter

#chrome
############################################################################

#raspi imager, packet tracer, chrome, pycharm, burpsuite, intellij


#Microsoft fonts
sudo apt install ttf-mscorefonts-installer; sudo fc-cache -f -v

#install these snaps
sudo snap install code --classic   #vscode
sudo snap install obsidian --classic   #obsidian.md

#IntelliJ
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.0.30876.tar.gz
tar -xf jetbrains-toolbox-2.3.0.30876.tar.gz
cd jetbrains-toolbox-2.3.0.30876
./jetbrains-toolbox


