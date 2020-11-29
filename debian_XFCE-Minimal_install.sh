#!/bin/bash

### Ps.: Para o gerenciador de Login, edite e troque USUARIO pelo nome de seu usuário do sistema

# Atualização 28.11.2020:
# Troca do link do thunar-shares-plugin para uma versão compilada por "Rina Rosalette (tangerine)":
# https://build.opensuse.org/package/show/home:tangerine:deb10-xfce-4.14/thunar-shares-plugin

# Referências para a atualização:
# https://linuxdicasesuporte.blogspot.com/2015/05/aprenda-usar-o-debian-testing-hibrido.html
# https://xpressubuntu.wordpress.com/2014/02/22/how-to-install-a-minimal-ubuntu-desktop/
# https://askubuntu.com/questions/179060/how-to-not-install-recommended-and-suggested-packages
# https://www.vivaolinux.com.br/dica/Instalando-o-XFCE-minimo
# https://www.devuan.org/os/documentation/dev1fanboy/en/minimal-xfce-install.html
# https://martincooper9.wordpress.com/2011/10/12/minimal-xfce-debian-install/
# https://linuxhint.com/install_xfce_debian_10/
# https://wiki.debian.org/pt_BR/Xfce
# https://wiki.debian.org/Xfce
# https://wiki.debian.org/PDF

# thunar-volman gvfs policykit-1 - support for auto-mounting
# task-xfce-desktop - Resolver problemas de atalhos e ícones, se necessário (Usar "--no-install-recommends" para instalar)
# gdebi - Instalador de pacotes .deb locais
# synaptic - Instalador de pacotes Debian remoto
# bash-completion - Tabulações automaticas

## Browsers
# brave - Mesmo motor do Chrome/Chromium, otimizado, abre sites mais rapidamente e consome menos memória RAM e focado em privacidade
# vivaldi - Mesmo que acima, leve e personalizável
# palemoon - Com base no Firefox, otimizado com algumas ferramentas próprias e para processadores modernos

# Atualização 19.04.2019:
# Removido link do Mint do xfce4-whiskermenu-plugin e adicionado pacote oficial do Debian. A partir do Debian Teste (21.01.2019)

#xfce4-mount-plugin - extensão de montagem para o painel do Xfce4
#gtk2-engines-xfce - motor de temas GTK+-2.0 para o Xfce
#gtk3-engines-xfce - GTK+-3.0 theme engine for Xfce
#xfce4-settings - aplicação gráfica para gerir as configurações do Xfce
#thunar-volman - extensões do Thunar para a gerencia de volumes

## Instalação do sistema, apenas "Utilitário Standard de Sistema"
## Pacotes instalados
# xfce4 - Xfce Lightweight Desktop Environment
# xfce4-power-manager - power manager for Xfce desktop
# thunar-archive-plugin - Archive plugin for Thunar file manager
# xarchiver - GTK+ frontend for most used compression formats
# slim - desktop-independent graphical login manager for X11 (REMOVIDO)
# wicd - wired and wireless network manager
# htop - interactive processes viewer
# sakura - simple but powerful libvte-based terminal emulator > SUBSTITUIDO POR lxterminal
# scrot - command line screen capture utility
# medit - Useful programming and around-programming text editor > SUBSTITUIDO POR mousepad
# mirage - fast and simple GTK+ image viewer > SUBSTITUIDO PELO PACOTE viewnior
# zathura - PDF viewer with a minimalistic interface > SUBSTITUIDO PELO xpdf
# vlc - multimedia player and streamer
# alsa-utils - Utilities for configuring and using ALSA
# openssh-server - secure shell (SSH) server, for secure access from remote machines
# samba - SMB/CIFS file, print, and login server for Unix
# winbind - service to resolve user and group information from Windows NT servers
# libnss-winbind - samba nameservice integration plugins
# cifs-utils - Common Internet File System utilities
# fusesmb - filesystem client based on the SMB file transfer protocol
# gvfs-backends - userspace virtual filesystem - backends. (gvfs ajuda a reconhecer o celular no computador)
# ntpdate - client for setting system time from NTP servers
# deborphan - program that can find unused packages, e.g. libraries
# rcconf - Debian Runlevel configuration tool
# gadmin-samba - Configurador gráfico para compartilhamento de arquivos (REMOVIDO)
# screenfetch - Mostra versão da distro mais algumas informações úteis

## file-roller = gestor de arquivamentos para o GNOME (opcional - instalar manual)
# Mais completo que o xarchiver, porém puxa mais 39,8 MB de pacotes e ocupa mais 144 MB no arquivo de sistemas

##	Pacotes não instalados, porém, opcionais
# geany - fast and lightweight IDE, editor

# A instalação dos pacotes com XFCE, inclui automaticamente os pacotes "lightdm, lightdm-gtk-greeter e light-locker"

#IDU0
if [ "$(id -u)" == "0" ]; then
echo "Deve executar o comando como usuario normal!"
exit 0
fi
#IDU0

# sudo 
if ! id | grep "sudo" >> /dev/null ; then
 echo "$USER deve estar configurado com sudo ativado!"
 	exit 1
fi
# sudo 

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

#echo "$archName"
echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Atualizando lista de pacotes: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
sudo apt update -qq
#Xorg minimo
sudo apt --no-install-recommends install -y xserver-xorg-core
#sudo apt --no-install-recommends install -y xserver-xorg-video-vesa
#sudo apt --no-install-recommends install -y xserver-xorg-video-intel
#sudo apt --no-install-recommends install -y xserver-xorg-video-nouveau
#sudo apt --no-install-recommends install -y xserver-xorg-video-nvidia
#sudo apt --no-install-recommends install -y xserver-xorg-video-ati
sudo apt --no-install-recommends install -y xserver-xorg-video-fbdev
sudo apt --no-install-recommends install -y xserver-xorg

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Instalando pacotes para interface gráfica XFCE: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
#sudo apt -y install xfce4 xfce4-power-manager xfce4-whiskermenu-plugin xfce4-mount-plugin xfce4-settings thunar-archive-plugin thunar-volman
# gtk2-engines-xfce gtk3-engines-xfce
sudo apt --no-install-recommends -y install xfce4 thunar-volman xfce4-power-manager
sudo apt --no-install-recommends install -y xfce4-whiskermenu-plugin xfce4-mount-plugin xfce4-settings thunar-archive-plugin
#apt --no-install-recommends install task-xfce-desktop
#sudo apt --no-install-recommends install -y gvfs policykit-1
sudo apt --no-install-recommends install -y lightdm

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Instalando aplicativos CLI: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
sudo apt -y install ntpdate deborphan rcconf screenfetch htop scrot

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Instalando aplicativos para redes: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
# Instalação de pacotes para rede e internet
sudo apt --no-install-recommends install -y wicd
#sudo apt --no-install-recommends install -y network-manager-gnome
#sed -i 's/false/true/g' /etc/NetworkManager/NetworkManager.conf

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Instalando aplciativos GUI: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
sudo apt -y install lxterminal viewnior mousepad xpdf xarchiver

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Instalando pacotes para Media: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
# Instalação de pacotes para media
#### Codecs e Audio/Video ###
#apt install -y ffmpeg gstreamer1.0-libav
#apt install -y gstreamer1.0-plugins-good
#apt install -y gstreamer1.0-plugins-bad
#apt install -y gstreamer1.0-plugins-ugly
#apt install -y gstreamer1.0-nice
sudo apt install -y vlc
#apt --no-install-recommends install -y vlc qt4-qtconfig
#apt --no-install-recommends -y install pulseaudio
#apt --no-install-recommends install -y xfce4-pulseaudio-plugin
sudo apt install -y alsa-utils

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Instalando pacotes para compressão: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
sudo apt -y install zip lhasa arj p7zip p7zip-full p7zip-rar unrar rar unace 
# unar (opcional, ocupa 4 MB)
# rpm (opcional, ocupa 1 MB)

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Iniciando configuração para Navegador: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
read -t 5
# Instalação de Navegador
navegador_install(){
clear
	echo "Qual dos navegadores deseja usar?"
	echo "1) Firefox Repositório Deb"
	echo "2) Firefox mozilla.org"
	echo "3) Google Chrome"
	echo "4) Brave Browser"
	echo "5) Vivaldi"
	echo "6) Palemoon"
	echo "0) Nenhum"
	read NAVEGADOR
  case $NAVEGADOR in
	1)
	FIREFOX=$(apt search firefox 2> /dev/null | grep -i $(echo "$LANG" | sed "s/_/-/" | cut -d"." -f"1") | awk '{printf $1}')
	sudo apt -y install "$FIREFOX"

	;;
	2)
if [ "$archName" == "amd64" ]; then
	arquitetura=linux64
else
	if [ "$archName" == "i386" ]; then
	arquiterura=linux
	else
	echo "Arquitetura não suportada."
	fi
fi
mkdir -p /opt
cd /opt
wget -c -O firefox-installer https://download.mozilla.org/?product=firefox-latest&os="$arquitetura"&lang=pt-BR
echo "Instalando o firefox, por favor aguarde..."
tar xjf firefox-installer -C /opt/ 2>/dev/null
chown -R $USER:$USER /opt/firefox
ln -sf /opt/firefox/firefox /usr/local/bin/firefox
rm -rf firefox-installer

menu_file=/usr/share/applications/
icon_path=/opt/firefox/browser/chrome/icons/default/default48.png
icon_install=/usr/share/icons/hicolor/48x48/apps/
ln -sf $icon_path $icon_install
cat << EOF > $menu_file/firefox.desktop
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Firefox
Comment=Navegador de internet
Exec=/opt/firefox/firefox
Icon=/usr/share/icons/hicolor/48x48/apps/default48.png
Categories=Network;WebBrowser;
Terminal=false
EOF
	;;
	3)
if [ "$archName" = i386 ];then
	echo "Chrome não possui suporte à arquitetura "$archName"..."
	echo "Instale manualmente um navegador alternativo de sua escolha!"
	read -t 5
  else
	mkdir -p /tmp
	apt clean ; wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_"$archName".deb -P /tmp ; dpkg -i /tmp/google-chrome-stable_current_"$archName".deb ; apt -f install ; rm -rfv /tmp/google-chrome-stable_current_"$archName".deb
fi
	;;
	4)
sudo apt install -y apt-transport-https curl gnupg
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch="$archName"] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -qq
sudo apt install -y brave-browser
	;;
	5)
	mkdir -p /tmp
wget https://downloads.vivaldi.com/stable/vivaldi-stable_3.4.2066.106-1_"$archName".deb -P /tmp
cd /tmp
sudo dpkg -i vivaldi-stable*_"$archName".deb
sudo apt -f install
sudo rm -rf vivaldi-stable*_"$archName".deb
cd -
	;;
	6)
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/home:stevenpusser.list
curl -fsSL https://download.opensuse.org/repositories/home:stevenpusser/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_stevenpusser.gpg > /dev/null
sudo apt update -qq
sudo apt install -y palemoon
	;;
	0)
	echo "Optou por não instalar nenhum navegador..."
	echo "Se necessário, deverá instalar manualmente o navegador de sua preferência!"
	;;
	*) navegador_install ;;
	esac
}
navegador_install

# limpeza de cache
limpeza_de_cache(){
clear
	echo "Deseja adicionar limpeza de cache a cada 5 Min. no sistema? Sim (S)/Não (N)"
	read LICA
  case $LICA in
	[Ss][Ii][Mm]|[Ss])
	echo "Setando para fazer limpeza de cache a cada 5 MIN..."
chmod 777 /etc/crontab
echo -e 'syscache' >> /etc/crontab
sed -i '/syscache/s/syscache/*\/5 * * * * root sysctl -w vm.drop_caches=3/g' /etc/crontab
chmod 644 /etc/crontab

## /etc/rc.local (opcional):
#sed -i "s/exit 0//g" /etc/rc.local
#echo "sysctl -w vm.drop_caches=3" >> /etc/rc.local
#echo "ntpdate-debian" >> /etc/rc.local
#echo "exit 0" >> /etc/rc.local
	;;
	[Nn][Ãã][Oo]|[Nn])
	echo "Não Setar para fazer limpeza de cache a cada 5 MIN..."
	;;
	*) limpeza_de_cache ;;
	esac
}
limpeza_de_cache
# limpeza de cache

echo -e "\n\n"
for i in `seq 10 -1 1` ; do echo -ne " Iniciando configurações para compartilhamentos: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
# compartilhamento de arquivos e pastas - SAMBA
instalacao_samba(){
clear
	echo "Deseja instalar e configurar compartilhamento no sistema - SAMBA? Sim (S)/Não (N)"
	read ISMB
  case $ISMB in
	[Ss][Ii][Mm]|[Ss])
	echo "A instalar e configurar o compartilhamento de arquivos e pastas..."
# Instalação de aplicativos de rede e compartilhamento
sudo apt -y install samba winbind libnss-winbind cifs-utils fusesmb gvfs-backends

# Pacote thunar-shares-plugin para compartilhamento fácil de pastas
wget -c https://download.opensuse.org/repositories/home:/tangerine:/deb10-xfce-4.14/Debian_10/"$archName"/thunar-shares-plugin_0.3.1-7_"$archName".deb -P /tmp/
dpkg -i /tmp/thunar-shares-plugin-*_"$archName".deb
rm -rf /tmp/thunar-shares-plugin-*_"$archName".deb

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
	[Ss][Ii][Mm]|[Ss])
	/usr/bin/user-smb "$USER"
	read -t 5
	echo "Para gerenciar o SAMBA de forma fácil, use o comando user-smb..."
	echo "Use user-smb com a opção --help ou -h para mais detalhes"
	;;
	[Nn][Ãã][Oo]|[Nn])
	echo "Para gerenciar o SAMBA de forma fácil, use o comando user-smb..."
	echo "Use a opção --help ou -h para mais detalhes"
	;;
	*) user_samba ;;
	esac
}
user_samba
	echo -e "\n\nPara gerenciar usuários no SAMBA de forma fácil, use o comando user-smb (--help|-h para mais detalhes)..."
	echo -e "Para compartilhar pastas, basta usar a opção de compartilhamento com \"BT Direito > Propriedades\"..."
	read -5
	;;
	[Nn][Ãã][Oo]|[Nn])
	echo "Você optou por não instalar e configurar o compartilhamento de arquivos e pastas..."
	;;
	*) instalacao_samba ;;
	esac
}
instalacao_samba
# compartilhamento de arquivos e pastas - SAMBA

## Setando comando dmidecode para usuario normal:
for i in `seq 5 -1 1` ; do echo -ne " Realizando algumas configurações: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
sudo chmod +s /usr/sbin/dmidecode 
sudo ln -s /usr/sbin/dmidecode /usr/bin/
sudo sysctl -w vm.drop_caches=3

# Desativando sugestões e recomendados no apt
echo -e 'APT::Install-Suggests "0";\nAPT::Install-Recommends "0";' | sudo tee -a /etc/apt/apt.conf

## Configuando arquivos da pasta /etc:

# Setando todos os usuários para o uso do fuse (NTFS)
sudo sed -i '/user_allow_other/s/#//g' /etc/fuse.conf

## Limpando configurações:
echo -e "\n\n"
for i in `seq 5 -1 1` ; do echo -ne " Fazendo limpeza das configurações e pacotes do sistema: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
	read -t 5
sudo apt clean
sudo apt autoclean
sudo apt -y autoremove
deborphan --guess-all | xargs sudo apt -f -y remove --purge

clear

echo -e "\n\n"
for i in `seq 5 -1 1` ; do echo -ne " Configuração terminada: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
for i in `seq 5 -1 1` ; do echo -ne " Se quiser usar o Wisker Menú, adicione como ítem para o Painel: $i SEGUNDOS para prosseguir\r" ; sleep 1 ; done
		clear
	echo "Todas as configurações terminaram, para iniciar no XFCE, reinicie o sistema!"
	echo -e "\n\n"


