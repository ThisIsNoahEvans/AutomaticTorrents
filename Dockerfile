# Ubuntu 20.04
FROM ubuntu:focal

# Update and install the required packages
RUN apt update && apt upgrade -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:transmissionbt/ppa
RUN apt update && apt upgrade -y
RUN apt install transmission-gtk transmission-cli transmission-common transmission-daemon -y

# Start 
CMD service transmission-daemon start

EXPOSE 9091