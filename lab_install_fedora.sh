#!/bin/bash

#install these programs
sudo dnf install openssh-server openvpn blender krita godot3 gimp \
  chromium-browser virtualbox gcc htop vim neovim nano \
  gcc g++ make lolcat fortune gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree tigervnc-viewer minicom git neofetch \
  git rpi-imager cpufetch isc-dhcp-client wget curl exfatprogs podman flatpak snapd -y

#Symbolic link between /var/lib/snapd/snap and /snap for the snap program
sudo ln -s /var/lib/snapd/snap /snap

#install these snaps
sudo snap install code --classic   #vscode
sudo snap install obsidian --classic   #obsidian.md
#sudo snap install rpi-imager  #raspberry pi imager
sudo snap install pycharm-community --classic   #pycharm community edition
sudo snap install intellij-idea-community --classic   #IntelliJ Community edition

#IntelliJ Toolbox
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.0.30876.tar.gz
tar -xf jetbrains-toolbox-2.3.0.30876.tar.gz
cd jetbrains-toolbox-2.3.0.30876
./jetbrains-toolbox
cd ..

#Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf localinstall google-chrome-stable_current_x86_64.rpm -y

#Microsoft Fonts
yum install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

#Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
