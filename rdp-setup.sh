#!/bin/bash

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils

# Install Node.js and npm
sudo apt-get install -y npm

# Install LocalTunnel
sudo npm install -g localtunnel

# Start LocalTunnel and open the RDP port
nohup lt --port 3389 &

# Install xrdp
sudo apt-get install -y xrdp
sudo systemctl enable xrdp
sudo systemctl start xrdp

# Allow RDP through the firewall
sudo ufw allow 3389

# Set up a default user for RDP
sudo adduser --disabled-password --gecos "" rdpuser
echo "rdpuser:rdppassword" | sudo chpasswd

# Output the LocalTunnel URL
echo "RDP setup completed. Use the LocalTunnel URL to connect."
echo "LocalTunnel URL: $(curl -s ifconfig.me):3389"
echo "Username: rdpuser"
echo "Password: rdppassword"
