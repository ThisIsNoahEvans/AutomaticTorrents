# Ubuntu 20.04
FROM ubuntu:focal


# Disable IPv6 for VPN
RUN sysctl -w net.ipv6.conf.all.disable_ipv6=1
RUN sysctl -w net.ipv6.conf.default.disable_ipv6=1
RUN sysctl -w net.ipv6.conf.lo.disable_ipv6=1


# Update repositories & install dependencies for PPA
RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:transmissionbt/ppa
# Update repositories & upgrade packages
RUN apt update && apt upgrade -y
# Install dependencies
RUN apt install transmission-gtk transmission-cli transmission-common transmission-daemon openvpn wget curl nano ca-certificates unzip -y



# Run the install script 
CMD curl -sSL https://raw.githubusercontent.com/ThisIsNoahEvans/AutomaticTorrents/main/setup.sh?token=GHSAT0AAAAAABXGJ3L2TEBZZT7HND54MCZGYYPNDWQ | bash

EXPOSE 9091