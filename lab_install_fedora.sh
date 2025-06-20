#!/bin/bash

#if dual-booting with Windows, this will allow the times to syncronize
timedatectl set-local-rtc 1

#install these programs
sudo dnf -y install openssh-server openvpn blender krita godot3 gimp \
  chromium gcc htop vim neovim nano \
  gcc g++ make lolcat gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree minicom git neofetch \
  git cpufetch wget curl exfatprogs podman flatpak pip polkit -y

#snap for Fedora
#sudo dnf install snapd -y
#sudo ln -s /var/lib/snapd/snap /snap


### Allow users to change their IP address in Gnome 42 (this may not work in the future)
sudo mkdir -p /etc/polkit-1/localauthority/50-local.d

sudo tee /etc/polkit-1/localauthority/50-local.d/99-allow-all-networkmanager.pkla > /dev/null <<EOF
[Allow all users to manage network]
Identity=unix-user:*
Action=org.freedesktop.NetworkManager.*
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF

sudo systemctl restart polkit


#virt manager
sudo dnf group info virtualization
sudo dnf group install --with-optional virtualization -y
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

#Installing dysk https://github.com/Canop/dysk?tab=readme-ov-file
cd /usr/bin
sudo wget https://dystroy.org/dysk/download/x86_64-linux/dysk
sudo chmod 755 ./dysk
cd ~

#Install webcamize https://github.com/cowtoolz/webcamize?tab=readme-ov-file#installation
mkdir .custom_programs
cd .custom_programs
git clone https://github.com/cowtoolz/webcamize && cd webcamize
sudo ln -s "$PWD/webcamize" /usr/local/bin/
cd ~

#Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

#install these flatpak images
flatpak install -y --noninteractive flathub com.visualstudio.code
flatpak install -y --noninteractive flathub md.obsidian.Obsidian
flatpak install -y --noninteractive flathub com.jetbrains.PyCharm-Community
flatpak install -y --noninteractive flathub com.jetbrains.IntelliJ-IDEA-Community
flatpak install -y --noninteractive flathub com.spotify.Client
flatpak install -y --noninteractive flathub org.raspberrypi.rpi-imager
flatpak install -y --noninteractive flathub uk.org.greenend.chiark.sgtatham.putty

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
yum -y install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

#Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker

#Block Steam
sudo dnf -y install dnf-plugins-core
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.backup
sudo echo "exclude=steam" >> /etc/dnf/dnf.conf


