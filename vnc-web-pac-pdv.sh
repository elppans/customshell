#!/bin/bash

# https://kanaka.github.io/noVNC/

# Baixar o pacote noVNC
wget -c https://github.com/elppans/conf/raw/master/novnc_web/kanaka-novnc_git-210823.tgz
tar -zxvf kanaka-novnc_git-210823.tgz -C /

# Criar página vnc_auto

cd /usr/share/kanaka-noVNC
ln -sf $(readlink -m vnc_lite.html) vnc_auto.html

# Definir vnc_lite como página default:

cd /usr/share/kanaka-noVNC
ln -sf $(readlink -m vnc_lite.html) index.html

# Desativar o noVNC do PDV
chmod -x /usr/local/bin/noVNC
sed -i '/[Vv][Nn][Cc]/ s/^/# /' /usr/local/bin/display.set
# mv /opt/webadmin/thirdparty/kanaka-noVNC /opt/webadmin/thirdparty/kanaka-noVNC.OLD

# Instalar x11vnc e adicionar a senha
sudo apt-get update
sudo apt-get -y install x11vnc
x11vnc -storepasswd

# Ativar serviço
systemctl daemon-reload
systemctl start x11vnc-browser.service
systemctl enable x11vnc-browser.service
systemctl status x11vnc-browser.service
