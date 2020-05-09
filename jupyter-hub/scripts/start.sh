#!/usr/bin/zsh
whoami
source ~/.zshrc
USERID=`whoami`
echo "User Id $USERID"
echo "Starting Jupyter..."
mkdir -p /home/$USERID/jupyter/samples
cp -rf /home/$USERID/samples/* /home/$USERID/jupyter/samples/
sudo su ; /opt/jupyterhub/bin/jupyterhub -f /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
