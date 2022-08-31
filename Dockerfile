FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:transmissionbt/ppa
RUN apt update && apt upgrade -y
RUN apt install transmission-gtk transmission-cli transmission-common transmission-daemon

EXPOSE 9091