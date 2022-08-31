FROM ubuntu:latest

RUN add-apt-repository ppa:transmissionbt/ppa && apt update && apt upgrade -y && apt install transmission-gtk transmission-cli transmission-common transmission-daemon

EXPOSE 9091