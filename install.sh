#!/bin/bash

echo "Aloitetaan asennus"
sudo apt update
sudo apt install ufw iptables
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo ufw enable
echo "Asennus valmis!"
