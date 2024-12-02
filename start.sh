#!/bin/bash

echo "Tarkistetaan UFW-asetus..."
sudo ufw status || sudo ufw enable

echo "Asetetaan UFW:n säännöt..."
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443

sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "UFW:n säännöt on asetettu!"
sudo ufw reload

sudo ufw status verbose

echo "Asetetaan iptables-säännöt..."

sudo iptables -F

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT   # SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT   # HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # HTTPS

sudo iptables -A INPUT -j DROP

echo "Tarkistetaan iptables-säännöt..."
sudo iptables -L
