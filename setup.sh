#!/bin/bash

################################################################################
# Configure Transmission and OpenVPN in the container.                         #
################################################################################

# Stop Transmission
service transmission-daemon stop
# Update the Transmission configuration file -- this will eventually be on GitHub when the repo is public
wget 'https://cdn.itsnoahevans.co.uk/content/automatictorrents/transmission-config.json' -O /etc/transmission-daemon/settings.json
# Start Transmission
service transmission-daemon start

