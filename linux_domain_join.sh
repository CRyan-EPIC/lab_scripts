#!/bin/bash
##Designed for Ubuntu 22.04 LTS by Dakota

read -p "What would you like to name this device? " deviceName
read -p "What is the domain URL, you would like to join? " domainName
echo "*** Updating Desktop ***"

sudo apt-get update
echo Installing realmd and samba
sudo apt install -y realmd samba

sudo hostnamectl hostname ${deviceName}.${domainName}
echo "Your Hostname is now: ${hostname}"
echo "Please be sure to configure DNS Settings in the desktop computer settings "
read -p "What is your primary DNS Server IP Address? " primaryDNSIP
read -p "What is your Secondary DNS Server IP Address? " secondaryDNSIP
sleep 2

sudo echo "nameserver ${primaryDNSIP}" | sudo tee -a /etc/resolv.conf
sleep 2

sudo echo "nameserver ${secondaryDNSIP}" | sudo tee -a /etc/resolv.conf
sleep 4

sudo sed -i '/^passwd:/ s/$/ winbind/' /etc/nsswitch.conf
sleep 4

sudo sed -i '/^group:/ s/$/ winbind/' /etc/nsswitch.conf
sleep 4

sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sleep 2

realm discover ${domainName}

echo "Joining ${domainName} Realm"
sudo realm join -v --membership-software=samba --client-software=winbind ${domainName}
sleep 4

sudo pam-auth-update --enable mkhomedir
sudo realm permit --all
sudo echo "%domain\ admins@${domainName}    ALL=(ALL) ALL" | sudo tee -a /etc/sudoers.d/domain-admin
echo Domain Join Complete
