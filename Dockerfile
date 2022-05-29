FROM archlinux:latest

RUN pacman -Syu --noconfirm zsh vim git docker

RUN sed -i '/root/s|/bin/bash|/usr/bin/zsh|' /etc/passwd

WORKDIR /root
RUN git clone 'https://github.com/dfxyz/dotfiles.git'
WORKDIR /root/dotfiles
RUN git submodule init
RUN git submodule update
RUN ./mklink.sh

RUN pacman -S --noconfirm openssh
RUN ssh-keygen -A
RUN mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
COPY ./resources/sshd_config /etc/ssh/
EXPOSE 2222/tcp

WORKDIR /
ENTRYPOINT zsh
