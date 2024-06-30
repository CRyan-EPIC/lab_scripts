#!/bin/bash

#install these programs
sudo apt update
sudo apt -o Apt::Get::Assume-Yes=true install snapd openssh-server openvpn blender krita godot3 gimp \
  chromium-browser virtualbox gcc htop docker.io vim neovim nano \
  gcc g++ make lolcat fortune gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree tigervnc-viewer minicom git neofetch \
  git rpi-imager cpufetch isc-dhcp-client wget curl exfatprogs podman flatpak -y

#Block Steam
sudo bash -c 'cat <<EOF > /etc/apt/preferences.d/steam.pref
Package: steam
Pin: release *
Pin-Priority: -1
EOF'

sudo bash -c 'cat <<EOF > /etc/apt/preferences.d/steam-installer.pref
Package: steam-installer
Pin: release *
Pin-Priority: -1
EOF'

sudo bash -c 'cat <<EOF > /etc/apt/preferences.d/steam-devices.pref
Package: steam-devices
Pin: release *
Pin-Priority: -1
EOF'


#GNS3
#sudo add-apt-repository ppa:gns3/ppa
#sudo apt update                                
#sudo apt -o Apt::Get::Assume-Yes=true install gns3-gui gns3-server -y
#sudo dpkg --add-architecture i386
#sudo apt update
#sudo apt -o Apt::Get::Assume-Yes=true install gns3-iou -y

#install Fedora media writer
flatpak install flathub org.fedoraproject.MediaWriter -y

#Microsoft fonts
sudo apt -o Apt::Get::Assume-Yes=true install ttf-mscorefonts-installer; sudo fc-cache -f -v

#Fixing the unit file for apt-news
sudo systemctl daemon-reload

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

#Burpsuite must do it manually
#Go to https://portswigger.net/burp/releases/community/latest
#chmod 700 ./burpsuite_community_linux_v*.sh
#./burpsuite_community_linux_v*.sh

#UEFI Dual Boot Screen
#git clone https://github.com/vinceliuice/grub2-themes.git
#cd grub2-themes
#sudo ./install.sh -b -t stylish
#cd ..

#Chrome
wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update 
sudo apt-get install google-chrome-stable -y

#packet tracer
#must be done manually

