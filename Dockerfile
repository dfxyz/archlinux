FROM archlinux

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm zsh vim git openssh docker docker-compose

WORKDIR /root
RUN git clone 'https://github.com/dfxyz/dotfiles.git'
WORKDIR /root/dotfiles
RUN git submodule init
RUN git submodule update
RUN ./mklink.sh


RUN ssh-keygen -A
RUN mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
COPY ./resources/sshd_config /etc/ssh/
EXPOSE 2222/tcp

RUN sed -i '/root/s|/bin/bash|/usr/bin/zsh|' /etc/passwd
CMD ["/usr/bin/zsh"]
WORKDIR /
