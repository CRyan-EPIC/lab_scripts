#!/bin/bash

#if dual-booting with Windows, this will allow the times to syncronize
timedatectl set-local-rtc 1

#install these programs
sudo dnf -y install openssh-server openvpn blender krita godot3 gimp \
  chromium gcc htop vim neovim nano \
  gcc g++ make lolcat gparted filezilla obs-studio \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree minicom git neofetch \
  git cpufetch wget curl exfatprogs podman flatpak pip

#snap for Fedora
#sudo dnf install snapd -y
#sudo ln -s /var/lib/snapd/snap /snap

#virt manager
sudo dnf group info virtualization
sudo dnf group install --with-optional virtualization -y
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

#Installing dysk https://github.com/Canop/dysk?tab=readme-ov-file
cd /usr/bin
sudo wget https://dystroy.org/dysk/download/x86_64-linux/dysk
chmod 755 ./dysk
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


###########Allowing the user to change the IP without a password - not tested
sudo dnf install polkit

# Define the policy directory
POLICY_DIR="/etc/polkit-1/localauthority/50-local.d"

# Create the directory if it does not exist
sudo mkdir -p "$POLICY_DIR"

# Define the policy file
POLICY_FILE="$POLICY_DIR/99-allow-network-changes.pkla"

# Create or overwrite the policy file
sudo bash -c 'cat > "$POLICY_FILE" <<EOF
[Allow all users to manage network]
Identity=unix-user:*
Action=org.freedesktop.NetworkManager.network-control
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF'

echo "Policy file created at $POLICY_FILE"

#!/bin/bash

# Get the username (default to the current user)
USER_TO_MODIFY=${1:-$USER}

# Detect the OS
if grep -q "Ubuntu" /etc/os-release; then
    OS="Ubuntu"
    GROUP="netdev"
elif grep -q "Fedora" /etc/os-release; then
    OS="Fedora"
    GROUP="wheel"
else
    echo "Unsupported OS. This script works on Ubuntu and Fedora only."
    exit 1
fi

echo "Detected OS: $OS"

echo "Adding $USER_TO_MODIFY to $GROUP group..."
sudo usermod -aG $GROUP $USER_TO_MODIFY

# Update sudoers file
echo "Updating sudoers for network commands..."
SUDOERS_FILE="/etc/sudoers.d/network_privileges"
echo "%$GROUP ALL=(ALL) NOPASSWD: /usr/sbin/ip, /usr/bin/nmcli, /usr/sbin/netplan" | sudo tee $SUDOERS_FILE > /dev/null
sudo chmod 440 $SUDOERS_FILE

# Configure Polkit for NetworkManager
echo "Configuring Polkit rules..."
POLKIT_FILE="/etc/polkit-1/localauthority/50-local.d/org.freedesktop.NetworkManager.pkla"
sudo tee $POLKIT_FILE > /dev/null <<EOF
[Allow NetworkManager]
Identity=unix-group:$GROUP
Action=org.freedesktop.NetworkManager.*
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF

# Restart polkit
echo "Restarting polkit..."
sudo systemctl restart polkit

echo "Configuration complete! Please log out and log back in for changes to take effect."
