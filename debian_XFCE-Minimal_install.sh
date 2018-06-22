#!/bin/bash

### Ps.: Para o gerenciador de Login, edite e troque USUARIO pelo nome de seu usuário do sistema

## Instalação do sistema, apenas "Utilitário Standard de Sistema"
## Pacotes instalados
# xfce4 - Xfce Lightweight Desktop Environment
# xfce4-power-manager - power manager for Xfce desktop
# thunar-archive-plugin - Archive plugin for Thunar file manager
# xarchiver - GTK+ frontend for most used compression formats
# slim - desktop-independent graphical login manager for X11 (REMOVIDO)
# wicd - wired and wireless network manager
# htop - interactive processes viewer
# sakura - simple but powerful libvte-based terminal emulator
# scrot - command line screen capture utility
# medit - Useful programming and around-programming text editor
# mirage - fast and simple GTK+ image viewer
# zathura - PDF viewer with a minimalistic interface
# vlc - multimedia player and streamer
# alsa-utils - Utilities for configuring and using ALSA
# openssh-server - secure shell (SSH) server, for secure access from remote machines
# samba - SMB/CIFS file, print, and login server for Unix
# winbind - service to resolve user and group information from Windows NT servers
# libnss-winbind - samba nameservice integration plugins
# cifs-utils - Common Internet File System utilities
# fusesmb - filesystem client based on the SMB file transfer protocol
# gvfs-backends - userspace virtual filesystem - backends
# ntpdate - client for setting system time from NTP servers
# deborphan - program that can find unused packages, e.g. libraries
# rcconf - Debian Runlevel configuration tool
# gadmin-samba - Configurador gráfico para compartilhamento de arquivos (REMOVIDO)
# screenfetch - Mostra versão da distro mais algumas informações úteis

## file-roller = gestor de arquivamentos para o GNOME (opcional - instalar manual)
# Mais completo que o xarchiver, porém puxa mais 39,8 MB de pacotes e ocupa mais 144 MB no arquivo de sistemas

## Suporte a pacotes para compressão/descompressão
# zip lhasa arj p7zip p7zip-full p7zip-rar unrar rar unace
# unar (opcional, ocupa 4 MB)
# rpm (opcional, ocupa 1 MB)

##	Pacotes não instalados, porém, opcionais
# terminology - Enlightenment efl based terminal emulator
# geany - fast and lightweight IDE, editor

#IDU0
if [ "$(id -u)" != "0" ]; then
echo "Deve executar o comando como super usuario!"
exit 0
fi
#IDU0

#Arquitetura da distro (return archName) -
checkArchitecture () {
	#Select Architecte
	checkArchName=`uname -m`

	case "$checkArchName" in
		"i386" | "i486" | "i586" | "i686")
			archName="i386"
			;;
		"amd64" | "x86_64")
			archName="amd64"
			;;
		*)
			echo "Não foi possível identificar a arquitetura dosistema!"
			exit 0
			;;
	esac
}
checkArchitecture

echo "$archName"

apt-get update
apt-get -y install xfce4 xfce4-power-manager thunar-archive-plugin wicd htop sakura scrot medit mirage zathura vlc alsa-utils \
openssh-server samba winbind libnss-winbind cifs-utils fusesmb gvfs-backends ntpdate deborphan rcconf screenfetch \
zip lhasa arj p7zip p7zip-full p7zip-rar unrar rar unace 
#slim

# Pacote thunar-shares-plugin para compartilhamento fácil de pastas
wget -c https://github.com/elppans/thunar-shares-plugin/raw/master/thunar-shares-plugin-0.2.0.git-5_amd64.deb -P /tmp/thunar-shares-plugin-0.2.0.git-5_amd64.deb
dpkg -i /tmp/thunar-shares-plugin-0.2.0.git-5_amd64.deb
rm -rf /tmp/thunar-shares-plugin-0.2.0.git-5_amd64.deb

# Pacote Wisker Menú para usar no XFCE
#https://launchpad.net/~gottcode/+archive/ubuntu/gcppa/+packages
wget -c https://launchpad.net/~gottcode/+archive/ubuntu/gcppa/+files/xfce4-whiskermenu-plugin_1.7.5-0ppa1~xenial1_amd64.deb -P /tmp/xfce4-whiskermenu-plugin_1.7.5-0ppa1~xenial1_amd64.deb
dpkg -i /tmp/xfce4-whiskermenu-plugin_1.7.5-0ppa1~xenial1_amd64.deb
rm -rf /tmp/xfce4-whiskermenu-plugin_1.7.5-0ppa1~xenial1_amd64.deb


read -t 5

## Navegadores:
navegador_install(){
clear
	echo "Qual dos 2 navegadores deseja usar?"
	echo "1) Firefox"
	echo "2) Google Chrome"
	echo "0) Nenhum"
	read NAVEGADOR
  case $NAVEGADOR in
	1)
	# Firefox (Security stable/updates)
	apt-get -y install firefox-esr firefox-esr-l10n-pt-br
	;;
	2)
	# Chrome no Debian (Opcional):
if [ "$archName" = i386 ];then
	echo "Chrome não possui suporte à arquitetura "$archName"..."
	echo "Instale manualmente um navegador alternativo de sua escolha!"
	read -t 5
  else
	mkdir -p /tmp
	apt-get clean ; wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_"$archName".deb -P /tmp ; dpkg -i google-chrome-stable_current_"$archName".deb ; apt-get -f install ; rm -rfv /tmp/google-chrome-stable_current_"$archName".deb
fi
	;;
	0)
	echo "Optou por não instalar nenhum navegador..."
	echo "Se necessário, deverá instalar manualmente o navegador de sua preferência!"
	;;
	*) navegador_install ;;
}
navegador_install

#/etc/fuse.conf
#/etc/slim.conf
#/etc/nsswitch.conf
#/etc/samba/smb.conf
#/etc/crontab

## Setando comando dmidecode para usuario normal:

chmod +s /usr/sbin/dmidecode 
ln -s /usr/sbin/dmidecode /usr/bin/
sysctl -w vm.drop_caches=3

## Configuando arquivos da pasta /etc:

# Setando todos os usuários para o uso do fuse (NTFS)
sed -i '/user_allow_other/s/#//g' /etc/fuse.conf

# Setando seu usuário para seleção padrão ao gerenciador de login (troque USUARIO pelo nome de seu usuario) (opcional)
#sed -i '/default_user/s/#//g' /etc/slim.conf
#sed -i "/default_user/s/simone/"$USER"/g" /etc/slim.conf

# Criando BKP e sobrescrevendo configuração do samba
mv /etc/samba/smb.conf /etc/samba/smb.conf.old
#sed -i '/server role/s/server role/#server role/g' /etc/samba/smb.conf
#sed -i '/wins support/s/#//g' /etc/samba/smb.conf
#sed -i '/wins support/s/no/yes/g' /etc/samba/smb.conf
wget https://github.com/elppans/conf/raw/master/smb.conf_Manjaro -O /etc/samba/smb.conf


# Setando suporte ao DNS para o compartilhamento
cp -rfv /etc/nsswitch.conf /etc/nsswitch.conf.old
sed -i "/hosts/s/hosts/#hosts/g" /etc/nsswitch.conf
sed -i "/hosts/s/dns/dns\nhosts: files mdns4_minimal \[NOTFOUND=return\] wins dns mdns4/g" /etc/nsswitch.conf

# Samba Share:

mkdir -p /var/lib/samba/usershare
groupadd -r sambashare
chown root:sambashare /var/lib/samba/usershare
chmod 1770 /var/lib/samba/usershare

# nmbd smbd winbindd:

systemctl enable nmbd smbd winbind
systemctl start nmbd smbd winbind
#systemctl status nmbd smbd winbind

# No smb.conf, deve estar habilitado os seguintes ítens:

#name resolve order = wins lmhosts hosts bcast
#usershare path = /var/lib/samba/usershare
#usershare max shares = 100
#usershare owner only = false
#usershare allow guests = yes
#force group = sambashare

## Configuração do samba:
# Caso não exista a pasta "Público" no home:
#mkdir -p ~/Público
#chmod -R 777 ~/Público

## Custom Bash para gerenciamento de usuários no samba:
# Com estes comandos é mais fácil adicionar/remover usuários ao compartilhento samba via linha de comando
wget https://github.com/elppans/user-samba/raw/master/user-smb_060616/user-smb -P /usr/bin
chmod +x /usr/bin/user-smb

# Adicionar o usuário ao grupo sambashare:

user_samba(){
clear
	echo "Deseja adicionar o usuário padrão ao SAMBA? Sim (S)/Não (N)"
	read USMB
  case $USMB in
	Sim|sim|S|s)
	/usr/bin/user-smb "$USER"
	read -t 5
	echo "Para gerenciar o SAMBA de forma fácil, use o comando user-smb..."
	echo "Use user-smb com a opção --help ou -h para mais detalhes"
	;;
	Não|não|N|n)
	echo "Para gerenciar o SAMBA de forma fácil, use o comando user-smb..."
	echo "Use a opção --help ou -h para mais detalhes"
	;;
	*) user_samba ;;
}
user_samba

### GADMIN-SAMBA
# Via terminal, chame o aplicativo com o comando "sudo gadmin-samba" (sem aspas).
# Na primeira vez em que usar o aplicativo e o mesmo perguntar se quer sobrescreveer as configurações do smb.conf, responda "NÃO";
# Vá até a aba "Shares", clique em "Shared Directory" e escolha qual pasta quer compartilhar e escolha um nome para o mesmo;
# Mais abaixo, Escolha "Read Only=no, available=yes, Browseable=yes, Writable=yes, guest ok=yes";
# Em "Directory mask" deixe como 0777, e em "Force user" adicione o usuário associado ao samba;
# Clique em "Add Access permissions" e deixe marcado "local computer, users, acces allowed e Write Access."
# Clique em "ADD" e em "Apply".
# Restarte o serviço nmbd e smbd ou reinicie o computador

# Setando limpeza de cache a cada 5 minutos (opcional)
chmod 777 /etc/crontab
echo -e 'syscache' >> /etc/crontab
sed -i '/syscache/s/syscache/*\/5 * * * * root sysctl -w vm.drop_caches=3/g' /etc/crontab
chmod 644 /etc/crontab

## /etc/rc.local (opcional):
#sed -i "s/exit 0//g" /etc/rc.local
#echo "sysctl -w vm.drop_caches=3" >> /etc/rc.local
#echo "ntpdate-debian" >> /etc/rc.local
#echo "exit 0" >> /etc/rc.local

## Limpando configurações:
apt-get clean
apt-get autoclean
deborphan --guess-all | xargs apt-get -f -y remove --purge

clear
	echo -e "\n\nPara gerenciar usuários no SAMBA de forma fácil, use o comando user-smb (--help|-h para mais detalhes)..."
	read -t 3
	echo -e "Para compartilhar pastas, basta usar a opção de compartilhamento com \"BT Direito > Propriedades\"..."
	read -t 3
	echo -e "Se quiser usar o Wisker Menú, adicione como ítem para o Painel..."
	read -t 5
	echo "Todas as configurações terminaram, para iniciar no XFCE, reinicie o sistema!"

# rcconf

##	Configuração do sources.list no Debian stable:
# Ps.: Todos os repositórios estão descomentados no sources.list original

#deb http://ftp.br.debian.org/debian/ stable main non-free contrib
#deb-src http://ftp.br.debian.org/debian/ stable main non-free contrib

#deb http://security.debian.org/ stable/updates main contrib non-free
#deb-src http://security.debian.org/ stable/updates main contrib non-free

## stable-updates, previously known as 'volatile'
#deb http://ftp.br.debian.org/debian/ stable-updates main contrib non-free
#deb-src http://ftp.br.debian.org/debian/ stable-updates main contrib non-free

## stable-backports, previously on backports.debian.org
#deb http://ftp.br.debian.org/debian/ stable-backports main contrib non-free
#deb-src http://ftp.br.debian.org/debian/ stable-backports main contrib non-free

## smb.conf
# http://paste.debian.net/368541/
# http://paste.debian.net/368695 - adduser-smb
# http://paste.debian.net/368696 - adduser-smb-ssh
# http://paste.debian.net/368698 - userdel-smb

## adduser-smb v_2
# http://paste.debian.net/776225/
# http://paste.debian.net/download/776225

## adduser-smb v_2.1
# http://paste.debian.net/776257/
# http://paste.debian.net/download/776257

## adduser-smb v_2.2
# http://paste.debian.net/776271/
# http://paste.debian.net/download/776271

## adduser-smb v_2.3
# http://paste.debian.net/776272/
# http://paste.debian.net/download/776272

## Remove Old adduser-smb and add user-smb:
# https://github.com/elppans/user-samba