FROM archlinux

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm zsh vim git openssh docker docker-compose

RUN sed -i '/root/s|/bin/bash|/usr/bin/zsh|' /etc/passwd

COPY ./resources/dotfiles /root/dotfiles
RUN /root/dotfiles/mklink.sh

RUN ssh-keygen -A
RUN mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
COPY ./resources/sshd_config /etc/ssh/
EXPOSE 22/tcp

CMD ["/usr/bin/zsh"]
WORKDIR /root

RUN pacman -S --noconfirm gcc
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rust.sh
RUN chmod +x ./rust.sh
RUN ./rust.sh -y
RUN rm ./rust.sh
