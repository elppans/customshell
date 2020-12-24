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

mkdir -p /etc/iptables
/sbin/iptables-save > /etc/iptables/rules.v4
/sbin/ip6tables-save > /etc/iptables/rules.v6
#/sbin/iptables-restore < /etc/iptables/rules.v4 >& /var/log/iptables-output
#/sbin/ip6tables-restore < /etc/iptables/rules.v6 >& /var/log/ip6tables-output
readlink -f $(which ip6tables-restore) | grep nft && update-alternatives --set ip6tables $(which ip6tables-legacy) || echo -e "ip6tables-restore OK"
readlink -f $(which iptables-restore) | grep nft && update-alternatives --set iptables $(which iptables-legacy) || echo -e "iptables-restore OK"

apt -y install ftp firewalld
apt policy firewalld

systemctl is-enabled firewalld && echo OK || systemctl enable firewalld
systemctl is-active firewalld && echo OK || systemctl start firewalld
firewall-cmd --state && echo OK || { echo -e "Falha" ; exit 1 ; }

ETHER=$(ip addr | grep -B 1 ether | head -1 | awk '{print $2}' | sed s/://)
firewall-cmd --zone=$(firewall-cmd --get-default-zone) --add-interface="$ETHER" --permanent
#firewall-cmd --zone=$(firewall-cmd --get-default-zone) --add-interface=lo
firewall-cmd --reload
firewall-cmd --get-zone-of-interface="$ETHER" --permanent
firewall-cmd --list-services
firewall-cmd --list-all

# Lista os serviços que podem ser ativados / desativados
# firewall-cmd --get-services

# Para obter uma lista de serviços, separe-os com vírgulas.
# firewall-cmd --add-service={http,https,smtp,imap} --permanent --zone=public

# Para obter a zona padrão
# firewall-cmd --get-default-zone

# visualizar a lista de zonas ativas onde exitem interfaces de rede ou fontes atribuídas
# firewall-cmd --get-active-zones

# lista todas as zonas disponíveis
# firewall-cmd --get-zones

# Para alterar o zona default para por exemplo a zona home
# firewall-cmd --set-default-zone=home

# Para pegarmos o valor permanente de uma zona especifica
# firewall-cmd --permanent --zone=public --list-all

# Crie uma nova zona
# firewall-cmd --new-zone=zonename --permanent

# Habilitar serviço / porta em uma zona específica
# firewall-cmd --zone=<zone> --add-port=<port>/tcp --permanent
# firewall-cmd --zone=<zone> --add-port=<port>/udp --permanent
# firewall-cmd --zone=<zone> --add-service=<service> --permanent
# firewall-cmd --zone=<zone> --add-service={service1,service2,service3} --permanent

# Adicionar uma interface a uma zona
# firewall-cmd --get-zone-of-interface=eth1 --permanent
# firewall-cmd --zone=<zone> --add-interface=eth1 --permanent

# visualizar as portas
# firewall-cmd --zone=internal --list-ports
# firewall-cmd --list-ports

# Listar regras avançadas
# firewall-cmd --list-rich-rules

# Configurar encaminhamento de porta
# Enable masquerading
# firewall-cmd --add-masquerade --permanent

# Port forward to a different port within same server ( 22 > 2022)
# firewall-cmd --add-forward-port=port=22:proto=tcp:toport=2022 --permanent

# Port forward to same port on a different server (local:22 > 192.168.2.10:22)
# firewall-cmd --add-forward-port=port=22:proto=tcp:toaddr=192.168.2.10 --permanent

# Port forward to different port on a different server (local:7071 > 10.50.142.37:9071)
# firewall-cmd --add-forward-port=port=7071:proto=tcp:toport=9071:toaddr=10.50.142.37 --permanent

# Removendo uma porta ou serviço
# Para remover uma porta ou serviço do firewall, substitua  --add por  –-remove em cada comando usado para habilitar o serviço.

# OPENING A TCP AND UDP PORT USING FIREWALL-CMD
# firewall-cmd --add-port=53/tcp
# firewall-cmd --add-port=53/udp

# REMOVING A TCP AND UDP PORT USING FIREWALL-CMD
# firewall-cmd --remove-port=53/tcp
# firewall-cmd --remove-port=53/udp

# ADDING A SERVICE USING FIREWALL-CMD
# firewall-cmd --add-service=http

# REMOVING A SERVICE USING FIREWALL-CMD
# firewall-cmd --remove-service=http

# BLOCKING A SPECIFIC IP ADDRESS USING FIREWALL-CMD
# firewall-cmd --add-rich-rule='rule family=ipv4 source address=192.168.17.112 reject'

# UNBLOCKING A BLOCKED IP ADDRESS USING FIREWALL-CMD
# firewall-cmd --remove-rich-rule='rule family=ipv4 source address=192.168.17.112 reject'

# ADDING RULES PERMANENTLY TO FIREWALLD
# firewall-cmd --add-service=https --permanent

# Now to reload the firewalld configuration, run the following command
# firewall-cmd --reload

#	FONTES:

# https://www.cyberciti.biz/faq/how-to-save-iptables-firewall-rules-permanently-on-linux/
# https://www.inmotionhosting.com/support/security/how-to-install-firewalld-on-linux/
# https://www.linuxnix.com/installing-configuring-firewalld-linux/
# https://codare.aurelio.net/2006/10/03/shell-use-e-e-ou-ao-inves-de-ifthenfi/
# https://computingforgeeks.com/how-to-install-and-configure-firewalld-on-debian/
# https://prodevsblog.com/questions/698348/ip6table-restore-failed-in-debian-buster-sid/
# https://stato.blog.br/wordpress/trabalhando-com-firewalld/
# https://www.programmersought.com/article/75003945780/
# https://www.how2shout.com/how-to/common-commands-for-the-centos-7-8-firewall-firewalld.html
# https://www.how2shout.com/how-to/common-commands-for-the-centos-7-8-firewall-firewalld.html

