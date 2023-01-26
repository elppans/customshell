#!/bin/bash

# Instalando Team Viwer no PDV

# Team Viewer EXIGE Interface gráfica E login via GUI.
# Então DEVE ser instalado novamente o GUI padrão do PDV, desabilitar o autologin via getty e habilitar autologin via GUI

# Instalando e configurando Team Viewer 

sudo sh -c "echo 'deb http://linux.teamviewer.com/deb stable main' >> /etc/apt/sources.list.d/teamviewer.list"
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C5E224500C1289C0
sudo apt-get update
sudo apt-get install teamviewer
dpkg -l teamviewer* | grep ^ii
echo -e '[Desktop Entry]
Version=1.0
Encoding=UTF-8
Type=Application
Categories=Network;

Name=TeamViewer
Comment=Remote control and meeting solution.
Exec=teamviewer -r

Icon=TeamViewer
' | tee ~/Desktop/TeamViewer.desktop
chmod +x ~/Desktop/TeamViewer.desktop
cp -v ~/Desktop/TeamViewer.desktop ~/.config/autostart 

# Instalando e configurando GUI padrão do PDV (LXDM)

sudo apt-get update
sudo apt-get -y install lxdm
sudo sed -i '/autologin/s/dgod/root/' /etc/lxdm/default.conf
sudo sed -i '/autologin/s/#//' /etc/lxdm/default.conf
sed -i 's/ExecStart=-/#ExecStart=-/' /etc/systemd/system/getty@tty1.service.d/override.conf

## Ps.: Se fizer alguma configuração ruim na barra (painel) do LXDE, resete com os seguintes comandos:

# rm -rf ~/.config/lxpanel
# cp -rf /etc/xdg/lxpanel ~/.config/
# lxpanelctl restart

## Após iniciar o sistema, configurar para ocultar a barra de tarefas

# Clique com o botão direito em cima da barra de tarefas (painel)  e clique em "Painel Settings"
# Vá até a aba "Advanced", procure "Automatic hiding" e clique para deixar marcado a opção "Minimize panel when not in use"
# Clique em Close

reboot

