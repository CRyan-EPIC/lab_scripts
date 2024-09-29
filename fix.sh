#!/bin/bash
sudo apt update
sudo apt install --reinstall linux-image-5.19.0-46-generic
sudo ubuntu-drivers install
sudo apt install -f
sudo apt autoclean
sudo apt autoremove -y
sudo timedatectl set-local-rtc 1
timedatectl set-local-rtc 1
sudo apt upgrade -y
