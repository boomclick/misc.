#!/bin/bash
#preparations for pi
#© 2018. This program is released into the public domain.

if [ "$(whoami)" == "root" ]; then
        printf "awesome! you're root, and the script must be run by root\\n"
else
        printf "you are not root, and the script must be run as root. exiting...\\n"
        exit
fi

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y progress vim deluge deluged deluge-console deluge-common nfs-kernel-server

#insert your ip on this line; setup for nfs
sudo echo "/home 		 169.254.117.235(rw,sync,fsid=0,crossmnt,no_subtree_check)" >> /etc/exports
sudo service nfs-server restart
showmount -e
sleep 2

#bfgminer dependencies

sudo apt-get install -y build-essential autoconf automake libtool pkg-config libcurl4-gnutls-dev libjansson-dev uthash-dev libncurses5-dev libudev-dev libusb-1.0-0-dev libevent-dev git

#make bfgminer with moonlander drivers

cd /home/pi
git clone --branch futurebit_driver https://github.com/jstefanop/bfgminer.git
cd bfgminer
./autogen.sh
./configure CFLAGS=-O3 --enable-scrypt --enable-futurebit
sudo make

#install mining script
cd /home/pi
wget https://gist.github.com/boomclick/6a7db4c3534db307d4e836cb05311bc7/raw/21cec6f0e4ddd04fd2817fcfecda50dec572ea38/miner.sh
chmod 755 miner.sh
chown pi miner.sh
