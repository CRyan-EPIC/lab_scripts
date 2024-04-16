#!/bin/bash
#find updates via apt
sudo apt update

#reinstall the kernel
sudo apt install --reinstall linux-image-`uname -r`

#reinstall the ubuntu drivers
sudo ubuntu-drivers install

#repair apt
sudo apt install -f
sudo apt autoclean
sudo apt autoremove -y

#set the timezone to rtc
sudo timedatectl set-local-rtc 1
timedatectl set-local-rtc 1

#update the OS and programs
sudo apt upgrade -y
