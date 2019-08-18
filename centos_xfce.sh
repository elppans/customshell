#!/bin/bash


#	Opções yum

# Salvar configuração no yum:
# yum-config-manager --save --setopt=protected_multilib=false >> /dev/null
# Desativar um repositório permanentemente:
# yum-config-manager --disable <repoid>
# Desativar repositório temporariamente executando outros parametros:
# yum --disablerepo=<repoid>
# yum-config-manager = pacote yum-utils

#	Fontes:
# https://www.vivaolinux.com.br/dica/Instalando-o-Xfce-no-CentOS-7
# https://medium.com/@m0blabs/centos-7-minimal-como-desktop-4e257f177676
# http://jensd.be/125/linux/rhel/install-mate-or-xfce-on-centos-7
# http://www.linuxguide.it/command_line/linux-manpage/do.php?file=yum
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sec-working_with_package_groups

# https://www.tecmint.com/vnc-desktop-access-from-web-browser/
# https://www.realvnc.com/pt/news/control-computer-within-your-web-browser/
# https://novnc.com/info.html > https://github.com/novnc/noVNC/blob/master/README.md#quick-start
# https://github.com/novnc/noVNC
# https://unix.stackexchange.com/questions/262219/how-to-use-web-browser-as-vnc-client


###	Instalação XFCE CentOS 7
##  Pacotes:
# @"X Window System": X Window System Support (Requerido)
# @Fonts: Fontes para renderizar textos em uma variedade de línguas e scripts. (requerido)
# @xfce: Um ambiente de trabalho leve que funciona bem em máquinas de baixo custo. (requerido - ssh+X)
# chromium: Chromium is an open-source web browser, powered by WebKit (Blink).
# file-roller: File Roller is an application for creating and viewing archives files, such as tar or zip files.
# gedit: gedit is a small, but powerful text editor designed specifically for the GNOME desktop.
# gvfs-fuse: This package provides support for applications not using gio to access the gvfs filesystems.
# htop: htop is an interactive text-mode process viewer for Linux, similar to top(1).
# mlocate: mlocate is a locate/updatedb implementation.
# nano: GNU nano is a small and friendly text editor.
# net-tools: The net-tools package contains basic networking tools, including ifconfig, netstat, route, and others.
# ntfs-3g: NTFS-3G is a stable, open source, GPL licensed, POSIX, read/write NTFS driver for Linux and many other operating systems.
# ristretto: Ristretto is a fast and lightweight image-viewer for the Xfce desktop environment.
# transmission-gtk: GTK graphical interface of Transmission BitTorrent client.
# unzip: The unzip utility is used to list, test, or extract files from a zip archive.
# wget: GNU Wget is a file retrieval utility which can use either the HTTP or FTP protocols.
# xfce4-screenshooter: The Xfce Screenshooter utility allows you to capture the entire screen, the active window or a selected region.
# xfce4-whiskermenu-plugin: Alternate application launcher for Xfce.
# xterm: The xterm program is a terminal emulator for the X Window System.
# zathura: Zathura is a highly customizable and functional document viewer.
# zip: The zip program is a compression and file packaging utility.

#	Opcional:
# file-roller transmission-gtk gedit
# chromium
# xrdp xorgxrdp = servidor RDP e conjunto de módulos X11 que fazem o Xorg funcionar como um backend para o xrdp

### Retirado
# lightdm lightdm-gtk = Gerenciador de Login
# xfce4-whiskermenu-plugin
# transmission-gtk

### Readicionado (removido de "--exclude=")"
# gdm  = Gerenciador de Login

### Adicionado
# ntsysv = interface simples para definir quais serviços do sistema são iniciados ou parados em vários runlevels


yum updateinfo
yum -y remove selinux
yum -y install epel-release yum-utils
yum-config-manager --save --setopt=protected_multilib=false >> /dev/null
yum updateinfo
yum -y upgrade

yum -y install @"X Window System" @Fonts @xfce \
xfce4-screenshooter ntsysv gvfs-fuse ntfs-3g \
ristretto xterm zathura htop nano wget mlocate zip unzip net-tools \
file-roller gedit chromium

echo -e "\nPort 22\nProtocol 2\nPermitRootLogin yes\nX11Forwarding yes" | tee -a /etc/ssh/sshd_config
echo -e '#/bin/bash\n\nssh -X -C "$@"' | tee "/usr/bin/ssh-x"
chmod +x "/usr/bin/ssh-x"

#wget https://github.com/elppans/conf/raw/master/skel_co7.v2.tgz -P /tmp
#tar -zxvf /tmp/skel_co7.v2.tgz -C /etc

ls -l /etc/systemd/system/default.target
systemctl set-default graphical.target
sed -i "/user_allow_other/s/#//g" /etc/fuse.conf
#sed -i "s/default/default,relatime/g" /etc/fstab
sed -i "s/enforcing/disabled/g" /etc/selinux/config
echo -e '\niptables -F' | tee -a /etc/rc.local >> /dev/null
echo "xfce4-session" | tee /etc/skel/.xsession >> /dev/null
echo "xfce4-session" | tee /etc/skel/.Xclients >> /dev/null
echo "xfce4-session" | tee ~/.xsession >> /dev/null
echo "xfce4-session" | tee ~/.Xclients >> /dev/null
chmod a+x /etc/skel/.xsession
chmod a+x /etc/skel/.Xclients
chmod a+x ~/.xsession
chmod a+x ~/.Xclients

###########################################################################################

#	Acessando o SSH server com suporte de execução de aplicações gráficas: 

# # ssh -X -C usuario@host -p porta

# Ou usar o comando customisado:

# # ssh-x IP

###########################################################################################

##	XRDP + XFCE

# # generate a file called .xsession in your home directory, and set default desktop
# echo "xfce4-session" > ~/.xsession

# # enable execute
# chmod a+x ~/.xsession

# # restart xrdp service
# systemctl restart xrdp

# # Hint: It works too if you replace `.xsession` with `.Xclients`
# Now, xrdp works perfectly with Xfce and openbox.

# Ps.: Todos os usuários devem ter os mesmos arquivos

# Fonte:
# https://github.com/neutrinolabs/xrdp/issues/765#issuecomment-394067006

###########################################################################################

#	Antes:
#free -m
#              total        used        free      shared  buff/cache   available
#Mem:           1982         120        1516           9         345        1679
#Swap:          1906           0        1906

# No XFCE:
#free -m
#              total        used        free      shared  buff/cache   available
#Mem:           1982         225        1358          12         398        1565
#Swap:          1906           0        1906
