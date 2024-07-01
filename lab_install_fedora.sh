#!/bin/bash

#install these programs
sudo dnf install openssh-server openvpn blender krita godot3 gimp \
  chromium virtualbox gcc htop vim neovim nano \
  gcc g++ make lolcat fortune gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree minicom git neofetch \
  git cpufetch isc-dhcp-client wget curl exfatprogs podman flatpak snapd pip -y

#Symbolic link between /var/lib/snapd/snap and /snap for the snap program
sudo ln -s /var/lib/snapd/snap /snap

#install these flatpak images
flatpak install flathub com.visualstudio.code
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.jetbrains.PyCharm-Community
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community
flatpak install flathub com.spotify.Client
flatpak install flathub org.raspberrypi.rpi-imager
flatpak install flathub uk.org.greenend.chiark.sgtatham.putty

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

#Block Steam
sudo dnf install dnf-plugins-core
sudo mkdir -p /etc/dnf/protected.d/
echo "[main]" | sudo tee /etc/dnf/protected.d/forbidden.conf
echo "exclude=steam" | sudo tee -a /etc/dnf/protected.d/forbidden.conf
echo "include=/etc/dnf/protected.d/*.conf" | sudo tee -a /etc/dnf/dnf.conf

