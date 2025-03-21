#!/bin/bash

# Update package list and system
sudo dnf check-update
sudo dnf upgrade -y

# Reinstall the current kernel version
sudo dnf reinstall kernel-core kernel-devel kernel-modules kernel-modules-extra

# Install all available drivers (Fedora automatically handles most drivers)
sudo dnf install -y akmod* kmod* 

# Force dependency resolution (equivalent to 'apt install -f')
#sudo dnf check
#sudo dnf distro-sync -y

# Clean up unused packages
sudo dnf autoremove -y
sudo dnf clean all

# Set the system clock to local time (for dual-boot with Windows)
#sudo timedatectl set-local-rtc 1 --adjust-system-clock
#timedatectl set-local-rtc 1 --adjust-system-clock

#Add Cron task
echo "15 15 * * * /usr/sbin/shutdown" >> mycron            #shutdown at 3:15pm
echo "@reboot /usr/sbin/modprobe -r kvm_intel" >> mycron  
sudo crontab mycron                                        #install new cron rules to sudo
rm mycron

