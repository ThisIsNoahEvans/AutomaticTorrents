# Ubuntu 20.04
FROM ubuntu:focal

# Update repositories & install dependencies for PPA
RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:transmissionbt/ppa
# Update repositories & upgrade packages
RUN apt update && apt upgrade -y
# Install transmission
RUN apt install transmission-gtk transmission-cli transmission-common transmission-daemon -y
# Install jq & nano
RUN apt install jq nano -y

# Start 
CMD service transmission-daemon start && sleep infinity

EXPOSE 9091