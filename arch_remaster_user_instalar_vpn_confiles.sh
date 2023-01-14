#!/bin/bash

if [ $(id -u) == 0 ]; then
    echo "Não execute $(basename "$0") como Super Usuário!"
    exit 1
fi

# Para usar os aplicativos xterm-beiraalta E/OU xterm-beiraalta-penalva, deve criar os arquivos de texto
# ~/.ssh/beiraalta E/OU ~/.ssh/beiraalta-penalva
# E adicionar a senha (SOMENTE A SENHA) do respectivo servidor DENTRO de cada arquivo.
# Apos isto, basta executar o aplicativo.

#tar -zcvf VPN_SOL.tgz .PlayOnLinux/wineprefix/VPN_SOL .PlayOnLinux/shortcuts/VPN_SOL .local/share/applications/VPN_SOL.desktop
#tar -zcvf VPN_RODRAF.tgz .PlayOnLinux/wineprefix/VPN_RODRAF .PlayOnLinux/shortcuts/VPN_RODRAF .local/share/applications/VPN_RODRAF.desktop
#tar -zcvf AtualizaBD.tgz .PlayOnLinux/wineprefix/AtualizaBD .PlayOnLinux/shortcuts/RtgAtualizaBD .local/share/applications/RtgAtualizaBD.desktop AtualizaBD

cd "$HOME"

wget -c https://www.dropbox.com/s/nvnbxvcb5tb2fau/VPN_RODRAF.tgz
wget -c https://www.dropbox.com/s/civfd05wxgc9nw8/VPN_SOL.tgz
tar -zxf VPN_RODRAF.tgz && rm -rf VPN_RODRAF.tgz
tar -zxf VPN_SOL.tgz && rm -rf VPN_SOL.tgz
sed -i 's/\/home\/manjaro/$HOME/' ~/.local/bin/VPN*

wget -c https://www.dropbox.com/s/57fybnptqdehft9/AtualizaBD.tgz
tar -zxf AtualizaBD.tgz && rm -rf AtualizaBD.tgz
sed -i '/Icon/s/^/#/' ~/.local/share/applications/RtgAtualizaBD.desktop
echo -e 'Icon=/usr/share/playonlinux/etc/playonlinux.png' | tee -a ~/.local/share/applications/RtgAtualizaBD.desktop >> /dev/null

mkdir ~/Custom
cd ~/Custom
wget -c https://www.dropbox.com/s/i3qci47og7430k6/SOMA_VENDA.tgz
wget -c https://www.dropbox.com/s/ygonwopuxbnb516/ImagensZanthus.tgz
tar -zxf SOMA_VENDA.tgz && rm -rf SOMA_VENDA.tgz
tar -zxf ImagensZanthus.tgz && rm -rf ImagensZanthus.tgz

sed -i "s/ubuntu/"$USER"/g" $HOME/.PlayOnLinux/shortcuts/*
sed -i "s/ubuntu/"$USER"/g" $HOME/.local/share/applications/*

sed -i 's/mint/$USER/g' ~/.PlayOnLinux/shortcuts/* && grep USER ~/.PlayOnLinux/shortcuts/*
#sed -i '/Categories/d' ~/.local/share/applications/RtgAtualizaBD.desktop
#sed -i '/Categories/d' ~/.local/share/applications/VPN_RODRAF.desktop
#sed -i '/Categories/d' ~/.local/share/applications/VPN_SOL.desktop
#echo -e 'Categories=Development;' | tee -a ~/.local/share/applications/RtgAtualizaBD.desktop
#echo -e 'Categories=Development;' | tee -a ~/.local/share/applications/VPN_RODRAF.desktop
#echo -e 'Categories=Development;' | tee -a ~/.local/share/applications/VPN_SOL.desktop

cd

wget -c https://github.com/elppans/conf/raw/master/arch_remaster_user_applications.tgz
wget -c https://github.com/elppans/conf/raw/master/arch_remaster_user_bin.tgz
wget -c https://github.com/elppans/conf/raw/master/arch_remaster_user_openfortigui.tgz
tar -zxf arch_remaster_user_applications.tgz && rm -rf arch_remaster_user_applications.tgz
tar -zxf arch_remaster_user_bin.tgz && rm -rf arch_remaster_user_bin.tgz
tar -zxf arch_remaster_user_openfortigui.tgz && rm -rf arch_remaster_user_openfortigui.tgz

wget -c https://www.dropbox.com/s/qv87242hco75c89/cisco-anyconnect_4.10.01075.tar.gz
wget -c https://www.dropbox.com/s/u3h7m72551euo29/cisco_lopes.xml
sudo tar -zxvf cisco-anyconnect_4.10.01075.tar.gz -C / && rm -rf cisco-anyconnect_4.10.01075.tar.gz
sudo mv -v cisco_lopes.xml /opt/cisco/anyconnect/profile
echo -e '/opt/cisco/anyconnect/lib' | sudo tee /etc/ld.so.conf.d/anyconnect.conf
ldconfig
sudo systemctl daemon-reload
sudo systemctl start vpnagentd.service
sudo systemctl enable vpnagentd.service
#systemctl status vpnagentd.service

bash -c ~/.local/bin/NetworkManager-VPN

#echo -e '[Desktop Entry]
#Encoding=UTF-8
#Name=RtgAtualizaBD
#Comment=PlayOnLinux
#Type=Application
#Exec=AtualizaBD
#Icon=wine
#StartupWMClass=RtgAtualizaBD312.exe
#Categories=Development;' | tee ~/.local/share/applications/RtgAtualizaBD.desktop >> /dev/null

#echo -e '[Desktop Entry]
#Encoding=UTF-8
#Name=VPN_RODRAF
#Comment=PlayOnLinux
#Type=Application
#Exec=VPN_RODRAF
#Icon=wine
#StartupWMClass=RODRAF.exe
#Categories=Development;' | tee ~/.local/share/applications/VPN_RODRAF.desktop >> /dev/null

#echo -e '[Desktop Entry]
#Encoding=UTF-8
#Name=VPN_SOL
#Comment=PlayOnLinux
#Type=Application
#Exec=VPN_SOL
#Icon=wine
#StartupWMClass=VPN_SOL.exe
#Categories=Development;' | tee ~/.local/share/applications/VPN_SOL.desktop >> /dev/null
