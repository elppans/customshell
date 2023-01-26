#!/bin/bash

# Instalando Team Viwer no PDV

#Team Viewer EXIGE Interface gráfica E login via GUI.
#Então DEVE ser instalado novamente o GUI padrão do PDV, desabilitar o autologin via getty e habilitar autologin via GUI

# Instalando e configurando GUI padrão do PDV (LXDM)
sudo apt-get update
sudo apt-get -y install lxdm
sudo sed -i '/autologin/s/dgod/root/' /etc/lxdm/default.conf
sudo sed -i '/autologin/s/#//' /etc/lxdm/default.conf
sed -i 's/ExecStart=-/#ExecStart=-/' /etc/systemd/system/getty@tty1.service.d/override.conf

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

reboot

