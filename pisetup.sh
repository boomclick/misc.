#!/bin/bash
#preparations for pi
#© 2018. This program is released into the public domain.

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y progress vim deluge deluged deluge-console deluge-common

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
