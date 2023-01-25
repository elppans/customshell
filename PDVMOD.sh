#!/bin/bash

## Instalação do pacote faltante, do script display.set 
sudo apt-get update && sudo apt-get -y install numlockx

## Execução de correção para os links quebrados desta versão do PDV
ldconfig 2> /tmp/simbolic && rm -rf $(cat /tmp/simbolic | cut -f '2' -d ':' | cut -f '2' -d ' ') && rm -rf /tmp/simbolic
ldconfig

## Adição de permissões para portas tty{ACM,USB,S}, para regras 
echo -e 'KERNEL=="ttyACM[0-9]*",MODE="0777"
KERNEL=="ttyUSB[0-9]*",MODE="0777"
KERNEL=="ttyS[0-9]*",MODE="0777"' | tee -a /etc/udev/rules.d/99-tty_permissoes.rules

## Adição dos usuários aos grupos necessários
## O grupo dialout é exigido pelo Wine, quando vai usar portas seriais para o mesmo e para o Proton, Lutris, Etc. 
sudo usermod -a -G dialout root
sudo usermod -a -G dialout user
#sudo usermod -a -G syslog user

## Atualização de campos do Script display.set 
sudo rm -rf /var/log/noVNC.log /var/log/x11vnc.log /tmp/displays
sudo sed -i 's/\/root/~/' /usr/local/bin/display.set
sudo sed -i 's/\/var\/log/\/tmp/' /usr/local/bin/display.set

## Adição do usuário ao sudoers (NOPASSWD) para a execução do PDV.
echo -e 'user ALL=(ALL:ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers


## Configurando sudo na execução do PDV
sudo sed -i 's/mainapp/sudo mainapp/' ~/.config/autostart/mainapp.desktop
sudo sed -i 's/xterm -e/xterm -e sudo/' ~/Desktop/PDV*
sudo sed -i 's/init/sudo init/' ~/Desktop/Desligar.desktop

## Trocando o usuário do autologin {tty}
sed -i 's/root/user/' /etc/systemd/system/getty@tty1.service.d/override.conf

## Copiando toda a configuração feita para o root, para o usuário
# Se preferir, apenas copie os arquivos .desktop
mv /home/user /home/user.bkp
cp -a /root /home/user
chown -R user.user /home/user /Zanthus

## Copiando os arquivos .desktop configurados para o root, para o usuário
#cp -a /home/user /home/user.bkp
#mkdir -p /home/user/.config/autostart
#cp -a ~/.config/autostart/* /home/user/.config/autostart
#cp -a ~/Desktop/* /home/user/Desktop
#cp -a ~/.bashrc /home/user
#chown -R user.user /home/user /Zanthus


