#!/bin/bash

#Updates and Prereqs
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install python3 python3-dev git curl lego -y
sudo mkdir /etc/mycerts

#Anaconda
#cd /tmp
#curl -O https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
#bash ./https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
#cd ~
#source ~/.bashrc


#Install TLJH
curl -L https://tljh.jupyter.org/bootstrap.py | sudo -E python3 - --admin cryan
sleep 5

#Limits to user accounts
sudo tljh-config set limits.memory 1G
sudo tljh-config set limits.cpu 1
sudo tljh-config set user_environment.default_app jupyterlab
sudo tljh-config set services.cull.every 600
sudo tljh-config set services.cull.timeout 3600
sudo tljh-config reload

#Adding Packages
#sudo -E conda install -c conda-forge gdal
#sudo -E pip install there
