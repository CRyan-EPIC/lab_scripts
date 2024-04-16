#!/bin/bash
#auto yes on apt
echo "APT::Get::Assume-Yes=yes" > /tmp/_tmp_apt.conf
export APT_CONFIG=/tmp/_tmp_apt.conf

#install these programs
sudo apt update
sudo apt -o Apt::Get::Assume-Yes=true install snapd openssh openvpn blender krita godot3 gimp \
  chromium-browser virtualbox* gcc top htop docker.io vim neovim nano \
  gns3-* gcc g++ make lolcat fortune gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark* timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree tigervnc-viewer -y

#flatpak update
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt -o Apt::Get::Assume-Yes=true install flatpak
sudo apt -o Apt::Get::Assume-Yes=true install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#install Fedora media writer
flatpak install flathub org.fedoraproject.MediaWriter

#Microsoft fonts
sudo apt install ttf-mscorefonts-installer; sudo fc-cache -f -v

#install these snaps
sudo snap install code --classic   #vscode
sudo snap install obsidian --classic   #obsidian.md
sudo snap install rpi-imager  #raspberry pi imager
sudo snap install pycharm-community --classic   #pycharm community edition
sudo snap install intellij-idea-community --classic   #IntelliJ Community edition

#IntelliJ Toolbox
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.0.30876.tar.gz
tar -xf jetbrains-toolbox-2.3.0.30876.tar.gz
cd jetbrains-toolbox-2.3.0.30876
./jetbrains-toolbox
cd ..

#packet tracer, chrome, burpsuite
