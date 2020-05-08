#docker build  . -t docker.io/goldentigerindia/archlinux-base:latest
FROM archlinux:latest
USER root
ARG USER_NAME="admin"
ARG USER_PASSWORD="Passw0rd"
ENV USER_NAME $USER_NAME
ENV USER_PASSWORD $USER_PASSWORD
ENV CONTAINER_IMAGE_VER=v1.0.0
RUN echo $USER_NAME
RUN echo $USER_PASSWORD
RUN echo $CONTAINER_IMAGE_VER
RUN pacman -Syu --noconfirm
RUN mkdir -p /home/$USER_NAME
WORKDIR /root/
RUN pacman -S git base-devel zsh curl wget sudo --noconfirm
RUN locale-gen en_US.UTF-8 \
  # add a user (--disabled-password: the user won't be able to use the account until the password is set)
  && useradd --shell /usr/bin/zsh --home-dir /home/$USER_NAME $USER_NAME \
  # update the password
  && echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd  && usermod -aG root $USER_NAME
# the user we're applying this too (otherwise it most likely install for root)
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN cat /etc/sudoers
RUN chown -R $USER_NAME:$USER_NAME /home/$USER_NAME
USER $USER_NAME
WORKDIR /home/$USER_NAME
# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster
# run the installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
SHELL ["/usr/bin/zsh", "-c"]
RUN cd /home/$USER_NAME && git clone https://aur.archlinux.org/miniconda3 && cd miniconda3 && makepkg -si --noconfirm && cd .. && rm -rf miniconda3
RUN source /opt/miniconda3/bin/activate root && conda init zsh
RUN cat ~/.zshrc

