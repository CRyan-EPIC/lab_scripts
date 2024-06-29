#Edit sudo to use apt, apt-get, gparted, openvpn, nmap, adduser, wireguard, wg-quick, docker, ufw

#### Open visudo
sudo visudo

#### Add these to visudo
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
ALL ALL=(ALL) NOPASSWD: /usr/bin/minicom    #minicom
ALL ALL=(ALL) NOPASSWD: /usr/sbin/ip        #ip a
ALL ALL=(ALL) NOPASSWD: /usr/bin/systemctl  #systemctl
ALL ALL=(ALL) NOPASSWD: /usr/sbin/dhclient  #dhclient
ALL ALL=(ALL) NOPASSWD: /usr/bin/dd         #dd
ALL ALL=(ALL) NOPASSWD: /usr/bin/mount      #mount
ALL ALL=(ALL) NOPASSWD: /usr/bin/umount     #umount
ALL ALL=(ALL) NOPASSWD: /usr/bin/podman     #podman
ALL ALL=(ALL) NOPASSWD: /usr/sbin/update-grub   #udate-grub

#### Save and exit
