#!/bin/bash

#if dual-booting with Windows, this will allow the times to syncronize
timedatectl set-local-rtc 1

#install these programs
sudo apt update
sudo apt -o Apt::Get::Assume-Yes=true install snapd openssh-server openvpn blender krita godot3 gimp \
  chromium-browser virtualbox gcc htop docker.io vim neovim nano \
  gcc g++ make lolcat fortune gparted filezilla obs-studio putty \
  fish zsh xrdp remmina make flatpak wireshark timeshift traceroute python3 \
  nmap zip gzip bzip2 wget curl unzip ufw tree tigervnc-viewer minicom git neofetch \
  git rpi-imager cpufetch isc-dhcp-client wget curl exfatprogs podman flatpak -y


#Installing dysk https://github.com/Canop/dysk?tab=readme-ov-file
cd /usr/bin
sudo wget https://dystroy.org/dysk/download/x86_64-linux/dysk
chmod 755 ./dysk
cd ~

#Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

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

#Flatpak
flatpak install flathub uk.org.greenend.chiark.sgtatham.putty

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
sudo snap install putty-gtk --edge

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


############## Allowing changing of IP addresses in the GUI ###################
sudo apt install policykit-1 -y
#!/bin/bash

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

#Add Cron task
echo "15 15 * * * /usr/sbin/shutdown" >> mycron            #shutdown at 3:15pm
echo "@reboot /usr/sbin/modprobe -r kvm_intel" >> mycron  
sudo crontab mycron                                        #install new cron rules to sudo
rm mycron

echo "Policy file created at $POLICY_FILE"

#Allow students to change the IP address
#sudo usermod -aG netdev $USER
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


