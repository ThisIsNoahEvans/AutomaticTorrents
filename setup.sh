#!/bin/bash

################################################################################
# Configure Transmission and OpenVPN in the container.                         #
################################################################################

echo "Configuring Transmission..."
# Stop Transmission
service transmission-daemon stop
# Update the Transmission configuration file -- this will eventually be on GitHub when the repo is public
wget 'https://cdn.itsnoahevans.co.uk/content/automatictorrents/transmission-config.json' -O /etc/transmission-daemon/settings.json
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
unzip -o -q ovpn.zip -d /etc/openvpn
rm ovpn.zip
echo ":: CD to /etc/openvpn/ovpn_udp/ "
cd /etc/openvpn/ovpn_udp/

# Create network device for VPN
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 0666 /dev/net/tun

# Connect to NordVPN
openvpn --config "$NORD_SERVER_ID.nordvpn.com.udp.ovpn" --auth-user-pass /nordvpn/userpass.txt --dev /dev/net/tun 
echo "Connected to NordVPN!"

sleep infinity