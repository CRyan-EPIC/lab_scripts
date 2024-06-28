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
  nmap zip gzip bzip2 wget curl unzip ufw tree tigervnc-viewer minicom git neofetch git rpi-imager -y

#flatpak update
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt -o Apt::Get::Assume-Yes=true install flatpak
sudo apt -o Apt::Get::Assume-Yes=true install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#install Fedora media writer
flatpak install flathub org.fedoraproject.MediaWriter -y

#Microsoft fonts
sudo apt install ttf-mscorefonts-installer; sudo fc-cache -f -v

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

#Burpsuite
wget https://portswigger.net/burp/releases/community/latest
chmod 700 ./burpsuite_community_linux_v2024_2_1_5.sh
./burpsuite_community_linux_v2024_2_1_5.sh

#UEFI Dual Boot Screen
#git clone https://github.com/vinceliuice/grub2-themes.git
#cd grub2-themes
#sudo ./install.sh -b -t stylish
#cd ..

#Edit sudo to use apt, apt-get, gparted, openvpn, nmap, adduser, wireguard, wg-quick, docker, ufw
#Add these to visudo
sudo visudo
ALL ALL=(ALL) NOPASSWD: /usr/bin/apt        #apt
ALL ALL=(ALL) NOPASSWD: /usr/bin/apt-get    #apt-get
ALL ALL=(ALL) NOPASSWD: /usr/bin/dpkg       #dpkg
ALL ALL=(ALL) NOPASSWD: /usr/bin/pip        #pip
ALL ALL=(ALL) NOPASSWD: /usr/bin/pip3       #pip3
ALL ALL=(ALL) NOPASSWD: /usr/sbin/iptables  #iptables
ALL ALL=(ALL) NOPASSWD: /usr/sbin/openvpn   #openvpn
ALL ALL=(ALL) NOPASSWD: /usr/sbin/adduser   #adduser
ALL ALL=(ALL) NOPASSWD: /usr/bin/nmap       #nmap
ALL ALL=(ALL) NOPASSWD: /usr/sbin/gparted   #gparted
ALL ALL=(ALL) NOPASSWD: /usr/bin/docker     #docker
ALL ALL=(ALL) NOPASSWD: /usr/sbin/ufw       #ufw
ALL ALL=(ALL) NOPASSWD: /usr/bin/wg-quick   #wireguard
ALL ALL=(ALL) NOPASSWD: /usr/bin/wireshark  #wireshark
ALL ALL=(ALL) NOPASSWD: /usr/bin/flatpak    #flatpak
ALL ALL=(ALL) NOPASSWD: /usr/bin/rpi-imager #rapsberry pi imager
ALL ALL=(ALL) NOPASSWD: /usr/bin/minicom    #minicom

pip, gparted, openvpn, nmap, adduser, wireguard, wg-quick, docker, ufw

#packet tracer, chrome, burpsuite

