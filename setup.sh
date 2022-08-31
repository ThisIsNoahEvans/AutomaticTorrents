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
# Disable IPv6 for VPN
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
# Save the NordVPN configuration file
printf "%s" "$NORD_USERNAME\n$NORD_PASSWORD" > "/nordvpn/userpass.txt"
# Setup NordVPN
cd /etc/openvpn
wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip
unzip -f ovpn.zip
rm ovpn.zip
cd /etc/openvpn/ovpn_udp/
ls
openvpn `$NORD_SERVER_ID.nordvpn.com.udp.ovpn` --auth-user-pass /nordvpn/userpass.txt
echo "Connected to NordVPN!"