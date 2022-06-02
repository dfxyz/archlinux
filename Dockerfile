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
