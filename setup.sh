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

echo "Configuring NordVPN..."
# Save the NordVPN configuration file
mkdir /nordvpn && cd /nordvpn
touch /nordvpn/userpass.txt
printf "%s" "$NORD_USERNAME\n$NORD_PASSWORD" > "/nordvpn/userpass.txt"
# Download and unzip the NordVPN servers
wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
unzip -f ovpn.zip -d /etc/openvpn
rm ovpn.zip
cd /etc/openvpn/ovpn_udp/
ls

# Connect to NordVPN
#openvpn `$NORD_SERVER_ID.nordvpn.com.udp.ovpn` --auth-user-pass /nordvpn/userpass.txt
echo "Connected to NordVPN!"

sleep infinity