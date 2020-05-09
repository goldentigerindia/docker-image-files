#docker build  . -t docker.io/goldentigerindia/archlinux-base:latest
FROM archlinux:latest
ARG USER_PASSWORD="Passw0rd"
ENV USER_PASSWORD $USER_PASSWORD
# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster
USER root
RUN echo "root:${USER_PASSWORD}" | chpasswd
ARG USER_NAME="admin"
ENV USER_NAME $USER_NAME
ENV CONTAINER_IMAGE_VER=v1.0.0
RUN echo $USER_NAME
RUN echo $USER_PASSWORD
RUN echo $CONTAINER_IMAGE_VER
RUN pacman -Syu --noconfirm
RUN mkdir -p /home/$USER_NAME
WORKDIR /root/
RUN pacman -S git base-devel zsh curl wget sudo python vi python-setuptools python-pip --noconfirm
RUN chsh -s /usr/bin/zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN locale-gen en_US.UTF-8 \
  # add a user (--disabled-password: the user won't be able to use the account until the password is set)
  && useradd --shell /usr/bin/zsh --home-dir /home/$USER_NAME $USER_NAME \
  # update the password
  && echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd  && usermod -aG root $USER_NAME
# the user we're applying this too (otherwise it most likely install for root)
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R $USER_NAME:$USER_NAME /home/$USER_NAME
USER $USER_NAME
WORKDIR /home/$USER_NAME
# run the installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
SHELL ["/usr/bin/zsh", "-c"]
