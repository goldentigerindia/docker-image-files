#docker build --no-cache . -t docker.io/goldentigerindia/jupyter-hub:latest
FROM goldentigerindia/archlinux-base:latest
ARG USER_NAME="admin"
ENV USER_NAME $USER_NAME
USER $USER_NAME
WORKDIR /home/$USER_NAME
RUN sudo python3 -m venv /opt/jupyterhub/
RUN sudo /opt/jupyterhub/bin/python3 -m pip install wheel
RUN sudo /opt/jupyterhub/bin/python3 -m pip install jupyterhub jupyterlab
RUN sudo /opt/jupyterhub/bin/python3 -m pip install ipywidgets
RUN sudo pacman -S nodejs npm --noconfirm
RUN sudo npm install -g configurable-http-proxy
RUN sudo mkdir -p /opt/jupyterhub/etc/jupyterhub/
RUN cd /opt/jupyterhub/etc/jupyterhub/ && sudo /opt/jupyterhub/bin/jupyterhub --generate-config
RUN sudo chmod 777 -R /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN echo "Changing Configuration files for Jupyter Hub..."
RUN sudo echo "c.Spawner.default_url = '/lab'" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo echo "c.JupyterHub.ip = '0.0.0.0'" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo echo "c.JupyterHub.port = 9999" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo echo "c.PAMAuthenticator.admin_groups = {'wheel'}" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo echo "c.JupyterHub.bind_url = 'http://:9999/'" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo echo "c.Spawner.cmd = ['/opt/jupyterhub/bin/jupyterhub-singleuser']" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo echo "c.Spawner.notebook_dir = '~/jupyter'" >> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
RUN sudo usermod -a -G wheel $USER_NAME
RUN sudo usermod -a -G root $USER_NAME
RUN echo "MiniConda environment..."
RUN cd /home/$USER_NAME && git clone https://aur.archlinux.org/miniconda3 && cd miniconda3 && makepkg -si --noconfirm 
RUN cd /home/$USER_NAME && rm -rf miniconda3
RUN sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
RUN sudo mkdir -p /opt/miniconda3/envs/
RUN sudo /opt/miniconda3/bin/conda create --prefix /opt/miniconda3/envs/python python=3.7 ipykernel
RUN sudo /opt/miniconda3/envs/python/bin/python -m ipykernel install --prefix=/opt/jupyterhub/ --name 'python' --display-name "Python (default)"
RUN sudo /opt/miniconda3/envs/python/bin/python -m ipykernel install --prefix /usr/local/ --name 'python' --display-name "Python (default)"
RUN source /opt/miniconda3/bin/activate root && conda init zsh
USER root
RUN source /opt/miniconda3/bin/activate root && conda init zsh
RUN mkdir -p ~/jupyter
RUN echo "PATH=/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/jupyterhub/bin:$PATH" >> /root/.zshrc
RUN npm install -g tslab
USER $USER_NAME
RUN sudo tslab install --python=/opt/jupyterhub/bin/python3
RUN echo "PATH=/home/$USER_NAME/.local/bin:$PATH" >> /home/$USER_NAME/.zshrc
RUN mkdir -p /home/$USER_NAME/samples
COPY samples/ /home/$USER_NAME/samples/
RUN sudo chmod 777 -R /home/$USER_NAME/samples
RUN ls -la /home/$USER_NAME/samples/*
RUN mkdir -p /home/$USER_NAME/scripts
COPY scripts/ /home/$USER_NAME/scripts/
RUN sudo chmod 777 -R /home/$USER_NAME/scripts
RUN ls -la /home/$USER_NAME/scripts/*
VOLUME /home/$USER_NAME/jupyter
EXPOSE 9999
ENTRYPOINT ["/home/admin/scripts/start.sh"]
