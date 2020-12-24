#!/bin/bash

#IDU0
if [ "$(id -u)" != "0" ]; then
echo "Deve executar o comando como Super Usuário!"
exit 0
fi
#IDU0

##      Usando arquivo de log - INÍCIO

# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "/var/log/"${0##*/}".log")

# faz o mesmo para a saída de ERROS

exec 2> >(tee -a "/var/log/"${0##*/}"_error.log")

##      Usando arquivo de log - FIM

# Usuário FTP a ser criado e configurado:

USUARIOFTP=ftpuser

# Instalar pacotes FTP

## Verificar zypper ou yum:
# openSUSE
if which zypper &>> /dev/null ; then
        echo zypper
        zypper refresh
        zypper -n in yast2-ftp-server vsftpd
# CentOS
elif which yum &>> /dev/null ; then
	echo yum
	yum updateinfo
	yum -y install vsftpd ftp
# Debian apt
elif which apt &>> /dev/null ; then
	echo apt
mkdir -p /etc/iptables
/sbin/iptables-save > /etc/iptables/rules.v4
/sbin/ip6tables-save > /etc/iptables/rules.v6
readlink -f $(which ip6tables-restore) | grep nft && update-alternatives --set ip6tables $(which ip6tables-legacy) || echo -e "ip6tables-restore OK"
readlink -f $(which iptables-restore) | grep nft && update-alternatives --set iptables $(which iptables-legacy) || echo -e "iptables-restore OK"
apt update
apt -y install vsftpd ftp firewalld
apt policy firewalld
systemctl is-enabled firewalld && echo OK || systemctl enable firewalld
systemctl is-active firewalld && echo OK || systemctl start firewalld
firewall-cmd --state && echo OK || { echo -e "Falha" ; exit 1 ; }
ETHER=$(ip addr | grep -B 1 ether | head -1 | awk '{print $2}' | sed s/://)
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --add-interface="$ETHER" --permanent
firewall-cmd --reload
firewall-cmd --list-services
# Debian apt-get
elif which apt-get &>> /dev/null ; then
	echo apt-get
mkdir -p /etc/iptables
/sbin/iptables-save > /etc/iptables/rules.v4
/sbin/ip6tables-save > /etc/iptables/rules.v6
readlink -f $(which ip6tables-restore) | grep nft && update-alternatives --set ip6tables $(which ip6tables-legacy) || echo -e "ip6tables-restore OK"
readlink -f $(which iptables-restore) | grep nft && update-alternatives --set iptables $(which iptables-legacy) || echo -e "iptables-restore OK"
apt-get update
apt-get -y install vsftpd ftp firewalld
systemctl is-enabled firewalld && echo OK || systemctl enable firewalld
systemctl is-active firewalld && echo OK || systemctl start firewalld
firewall-cmd --state && echo OK || { echo -e "Falha" ; exit 1 ; }
ETHER=$(ip addr | grep -B 1 ether | head -1 | awk '{print $2}' | sed s/://)
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --add-interface="$ETHER" --permanent
firewall-cmd --reload
firewall-cmd --list-services
# Arch/Manjaro pacman
elif which pacman &>> /dev/null ; then
	echo pacman
pacman --noconfirm -Syy vsftpd firewalld

systemctl is-enabled firewalld && echo OK || systemctl enable firewalld
systemctl is-active firewalld && echo OK || systemctl start firewalld
firewall-cmd --state && echo OK || { echo -e "Falha" ; exit 1 ; }

ETHER=$(ip addr | grep -B 1 ether | head -1 | awk '{print $2}' | sed s/://)
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --add-interface="$ETHER" --permanent
firewall-cmd --reload
firewall-cmd --get-zone-of-interface="$ETHER" --permanent
firewall-cmd --list-services
firewall-cmd --list-all
# Nenhum
 else
     	echo -e "Falha!"
     	exit 1
fi


# Ativar selinux (Se não ativado):
# Se desativado e quiser usar o selinux, deverá reiniciar o sistema antes de prosseguir
#sed -i "/SELINUX/s/disabled/enforcing/g" /etc/selinux/config
#sestatus
if which sestatus &>> /dev/null ; then
        sestatus
fi

# Verificar status do FirewallD e ativar (Se não ativado):
systemctl is-enabled firewalld && echo OK || systemctl enable firewalld
systemctl is-active firewalld && echo OK || systemctl start firewalld
firewall-cmd --state && echo OK || { echo -e "Falha" ; exit 1 ; }
#systemctl status firewalld

# Configuração do Firewall, liberar portas e serviços:

firewall-cmd --permanent --add-port=21/tcp
firewall-cmd --permanent --add-service={ftp,tftp}
firewall-cmd --reload
firewall-cmd --list-services

# CentOS
# setsebool -P ftp_home_dir on # Em versões recentes do CentOS, esta opção não existe, deve usar "ftpd_full_access"
if which setsebool &>> /dev/null ; then
        setsebool -P ftpd_full_access on
fi
# CentOS

# Configurando hosts e nss:

cp -v /etc/nsswitch.conf /etc/nsswitch.conf_$(date +%m%d%Y-%H%M%S).backup
MDNSMIN=mdns_minimal
MDNS=mdns

sed -i "/dns/s/^/#/" /etc/nsswitch.conf
sed -i "/networks/s/#//g" /etc/nsswitch.conf
echo -e "hosts: files $MDNSMIN [NOTFOUND=return] wins dns $MDNS\n" | tee -a /etc/nsswitch.conf

FTPDIR=/srv/ftp
FTPFILE=vsftpd.conf

# Procurar e renomear arquivo de configuração padrão FTP para backup:

find /etc -type f -name "$FTPFILE" -exec rename -v "$FTPFILE" "$FTPFILE"_$(date +%m%d%Y-%H%M%S).backup {} \;

# Criar arquivo de configuração padrão FTP (Padrão openSUSE):
touch /etc/vsftpd.conf

# Criar arquivo de lista de usuários FTP (Padrão openSUSE):
touch /etc/vsftpd.chroot_list
ln -sf /etc/vsftpd.chroot_list /etc/vsftpd.user_list
echo 'anonymous' | tee /etc/vsftpd.user_list >> /dev/null

# CentOS
# Criar link dos arquivos de configuração padrão openSUSE para o padrão do CentOS
mkdir -p /etc/vsftpd
ln -sf /etc/vsftpd.chroot_list /etc/vsftpd/chroot_list
ln -sf /etc/vsftpd.conf /etc/vsftpd/vsftpd.conf
# CentOS

# Configuração do FTP:

echo -e "
write_enable=YES
dirmessage_enable=YES
ftpd_banner=Bem vindo ao VM $(hostname) FTP!
hide_ids=YES
local_enable=YES
local_umask=002
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
anonymous_enable=YES
anon_world_readable_only=YES
anon_umask=077
syslog_enable=YES
connect_from_port_20=YES
ascii_upload_enable=YES
pam_service_name=vsftpd
listen=YES
ssl_enable=NO
dsa_cert_file=
pasv_min_port=30000
pasv_max_port=30100
anon_mkdir_write_enable=NO
anon_root=/srv/ftp/pub
anon_upload_enable=NO
idle_session_timeout=900
log_ftp_protocol=YES
max_clients=10
max_per_ip=3
pasv_enable=YES
ssl_tlsv1=YES
xferlog_enable=YES
user_sub_token=\$USER
local_root=/srv/ftp/\$USER
pasv_address=$(hostname -I | awk '{print $1}')
tcp_wrappers=YES
chown_uploads=YES
xferlog_std_format=YES
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd.user_list
ftp_username=nobody
ascii_download_enable=YES
allow_writeable_chroot=YES
no_anon_password=YES
" | tee /etc/vsftpd.conf

# CentOS
# Desabilitando a linha "chroot_list_enable". Por algum motivo, o chroot não funciona se estiver habilitado
sed -i '/chroot_list_enable/s/^/#/' /etc/vsftpd.conf
# CentOS

# SUSE
# Desabilitando a linha "tcp_wrappers". O SUSE não tem suporte a este parâmetro
sed -i '/tcp_wrappers/s/^/#/' /etc/vsftpd.conf
# SUSE

# Criar Diretório FTP padrão
mkdir -p $FTPDIR
chown .ftp $FTPDIR

# Criar pasta pub no Diretório FTP para anonymous com permissões não padrão
mkdir -p /nonexistent
mkdir -p -m 775 $FTPDIR/pub
chown .ftp $FTPDIR/pub

##	Configuração de usuário FTP - INÍCIO

## Este trecho pode ser usado como um comando em Sheel simples de criação de usuário FTP: ftp-user-add
# Trocando o parâmetro "$USUARIOFTP" por "$1"

# Variável de configuração para o usuário:

echo -e "Criando comando para remoção de Usuário FTP"
echo -e "Para usar faça o comando: ftp-user-del USUÁRIO"
sleep 5

touch /usr/bin/ftp-user-del
chmod +x /usr/bin/ftp-user-del
cat <<'EOF' > /usr/bin/ftp-user-del
#!/bin/bash

if [ ! $(id -u) == "0" ]; then
        echo -e "Deve executar como Super usuário!"
        exit 0
fi

USER="$1"
PARTFUSER="/srv/ftp/$USER/pub"

if mount | grep "$PARTFUSER" >> /dev/null ; then
        umount "$PARTFUSER"
fi

MOUNTED=`mount | grep "$PARTFUSER"`

if [ "$MOUNTED" = "" ]; then
    echo -e "Partição do Usuário FTP $USER foi desmontado!"
  else
        echo -e "Deve desmontar a partição "$PARTFUSER" manualmente!"
        exit 1
fi

sed -i "/$USER BIND/d" /etc/fstab
sed -i "/\/srv\/ftp\/$USER\/pub/d" /etc/fstab

sed -i "/$USER/d" /etc/vsftpd.chroot_list

userdel -r "$USER"
EOF

echo -e "Criando comando para Criação de Usuário FTP"
echo -e "Para usar faça o comando: ftp-user-add USUÁRIO"
sleep 5

touch /usr/bin/ftp-user-add
chmod +x /usr/bin/ftp-user-add
cat <<'EOF' > /usr/bin/ftp-user-add
#!/bin/bash

if [ ! $(id -u) == "0" ]; then
        echo -e "Deve executar como Super usuário!"
        exit 0
fi

USER="$1"
GROUP=ftp
GROUPID=$(id -g $GROUP)

if [ ! -z "$USER" ]; then
        echo -e "usuário FTP $USER será criado..."
 else
echo "Usuário não especificado!"
exit 0
fi

# Criar um usuário para uso do FTP com um grupo primário em um grupo FTP existente:
#if which adduser &>> /dev/null ; then
#	adduser --home-dir /srv/ftp/$USER --gid $GROUPID --groups $GROUPID $USER
 #else
useradd --home-dir /srv/ftp/$USER --no-create-home --gid $GROUPID --groups $GROUPID $USER
#fi

passwd $USER

# Criar uma pasta pub do usuário FTP:
mkdir -p /srv/ftp/$USER/pub
chown -R $USER.$GROUPID /srv/ftp/$USER
#runuser -u "$USER" mkdir -p /srv/ftp/$USER/pub

# Adicionar o usuário no arquivo de lista de usuários FTP:
echo -e "$USER" | sudo tee -a /etc/vsftpd.chroot_list

# Configurar BIND do  ~/ftp/pub para pub do usuário FTP no /etc/fstab:
cp -v /etc/fstab /etc/fstab_$(date +%m%d%Y-%H%M%S).backup
echo -e "\n# $USER BIND FTP\n/srv/ftp/pub /srv/ftp/$USER/pub none gid=$GROUPID,umask=002,bind\t0\t0" | tee -a /etc/fstab
mount /srv/ftp/$USER/pub

# Reiniciar o serviço vsftpd
systemctl restart vsftpd
EOF

ftp-user-add $USUARIOFTP

##	Configuração de usuário FTP - FIM


# Verificar serviço FTP e ativar para a inicialização
systemctl enable vsftpd
systemctl status vsftpd


