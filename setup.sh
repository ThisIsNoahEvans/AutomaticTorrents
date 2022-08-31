#!/bin/bash

################################################################################
# Configure Transmission and OpenVPN in the container.                         #
################################################################################

echo "Configuring DNS..."
# Set Cloudflare DNS
echo 'nameserver 1.1.1.1' > /etc/resolv.conf

echo "Configuring Transmission..."
# Stop Transmission
service transmission-daemon stop
# Update the Transmission configuration file -- this will eventually be on GitHub when the repo is public
wget 'https://github.com/ThisIsNoahEvans/AutomaticTorrents/raw/main/transmission-config.json' -O /etc/transmission-daemon/settings.json
# Start Transmission
service transmission-daemon start

echo ":: Configuring NordVPN..."
# Save the NordVPN configuration file
echo ":: Creating files..."
mkdir /etc/openvpn
mkdir /nordvpn && cd /nordvpn
touch /nordvpn/userpass.txt
echo ":: Adding user and password..."
( echo $NORD_USERNAME ; echo $NORD_PASSWORD) > "/nordvpn/userpass.txt"


# Download and unzip the NordVPN servers
echo ":: Downloading NordVPN servers..."
wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
echo ":: Unzipping..."
unzip -o -q ovpn.zip -d /etc/openvpn # Unzip and overwrite any existing content
rm ovpn.zip
cd /etc/openvpn/ovpn_udp/

# Connect to NordVPN
echo ":: Connecting to NordVPN..."
openvpn --config "$NORD_SERVER_ID.nordvpn.com.udp.ovpn" --auth-user-pass /nordvpn/userpass.txt
echo "Connected to NordVPN!"

echo "::::::::::::: LAUNCH COMPLETE :::::::::::::"
# Keep the container running
sleep infinity