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

#	Opcional:
# file-roller transmission-gtk gedit
# chromium
# xrdp xorgxrdp = servidor RDP e conjunto de módulos X11 que fazem o Xorg funcionar como um backend para o xrdp

###	Requerido
# @Fonts = ssh + X

### Retirado
# lightdm lightdm-gtk = Gerenciador de Login

### Readicionado (removido de "--exclude=")"
# gdm  = Gerenciador de Login

### Adicionado
# ntsysv = interface simples para definir quais serviços do sistema são iniciados ou parados em vários runlevels

yum-config-manager --save --setopt=protected_multilib=false >> /dev/null
yum updateinfo
yum -y remove selinux
yum -y install epel-release yum-utils
yum updateinfo
yum -y upgrade

yum -y install @"X Window System" @Fonts @xfce \
xfce4-whiskermenu-plugin xfce4-screenshooter gvfs-fuse ntfs-3g \
ristretto xterm zathura htop nano wget mlocate zip unzip net-tools \
file-roller transmission-gtk gedit chromium

echo -e "\nPort 22\nProtocol 2\nPermitRootLogin yes\nX11Forwarding yes" | tee -a /etc/ssh/sshd_config
echo -e '#/bin/bash\n\nssh -X -C "$@"' | tee "/usr/bin/ssh-x"
chmod +x "/usr/bin/ssh-x"

wget https://github.com/elppans/conf/raw/master/skel_co7.v2.tgz -P /tmp

tar -zxvf /tmp/skel_co7.v2.tgz -C /etc

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

##	VNC via Browser (Fail)

#yum -y install x11vnc novnc libvncserver
#openssl req -new -x509 -days 365 -nodes -out self.pem -keyout self.pem
#echo -e 'centos\ncentos' | x11vnc -storepasswd
#novnc_server --vnc 127.0.0.1:5900
#x11vnc -forever -display :0 -cursor arrow -shared -rfbport 5900 -permitfiletransfer -localhost

#yum -y install tigervnc-server xorg-x11-fonts-Type1
#echo -e 'centos\ncentos' | vncpasswd
#iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5901 -j ACCEPT
#iptables -I INPUT 5 -m state --state NEW -m tcp -p tcp -m multiport --dports 5902:5904 -j ACCEPT
#service iptables save
#service iptables restart
#yum -y install java-1.8.0-openjdk
#yum -y install httpd httpd-devel

#mkdir -p /var/www/html/vncweb
#cd /var/www/html/vncweb
#wget http://www.tightvnc.com/download/2.7.2/tvnjviewer-2.7.2-bin.zip
#unzip -o tvnjviewer-2.7.2-bin.zip 
#mv viewer-applet-example.html index.htmlwwww
#https://www.tecmint.com/install-tightvnc-remote-desktop/



#Warning: could not find self.pem
#Starting webserver and WebSockets proxy on port 6080
#WARNING: no 'numpy' module, HyBi protocol will be slower
#Aviso: não foi possível encontrar self.pem
#Iniciando o servidor da Web e o proxy WebSockets na porta 6080
#AVISO: nenhum módulo 'numpy', o protocolo HyBi será mais lento



################

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
