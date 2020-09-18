#!/bin/bash

#OpenVPN no CentOS 7:
#https://www.cyberciti.biz/faq/centos-7-0-set-up-openvpn-server-in-5-minutes/
#https://www.cyberciti.biz/faq/linux-import-openvpn-ovpn-file-with-networkmanager-commandline/
#https://johnhowto.wordpress.com/2014/08/21/openvpn-tcpudp-socket-bind-failed-on-local-address-already-in-use/

echo "Instalando dependências..."
sleep 5
yum updateinfo
yum -y install bind-utils lsof nmap-ncat

echo "Encontrando endereço IP..."
IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | head -1)
export IP

echo "Encontrando endereço IPV4..."
sleep 5
dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}' | tee ~/ipv4.txt
ENDPOINT=`cat ~/ipv4.txt`

echo "Encontrando endereço IPV6..."
sleep 5
dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}' | tee ~/ipv6.txt

echo "Baixando e executando Script de instalação do OpenVPN..."
sleep 5
mkdir -p /opt/ovpn
cd /opt/ovpn
wget https://raw.githubusercontent.com/elppans/customshell/master/centos7-vpn.sh
chmod +x centos7-vpn.sh
APPROVE_IP=y
IPV6_SUPPORT=n
PORT_CHOICE=1
PROTOCOL_CHOICE=1
DNS=1
COMPRESSION_ENABLED=n
CUSTOMIZE_ENC=n
./centos7-vpn.sh

echo "Verificando status do serviço OpenVPN Server..."
sleep 5
systemctl status openvpn-server@server.service
#systemctl start openvpn@server

echo "Verificar se há erros no servidor OpenVPN..."
sleep 5
journalctl --identifier openvpn

echo "Verificar se firewall está configurada corretamente.."
sleep 5
PORT=`cat /etc/openvpn/server.conf | grep port | awk '{print $2}'`
echo -e "Porta configurada: "$PORT""
cat /etc/iptables/add-openvpn-rules.sh

echo "Executar os comandos iptables e sysctl para verificar a configuração da regra NAT do servidor..."
sleep 5
iptables -t nat -L -n -v # Deve aparecer o IP configurado na porta e onde aponta o destino
sysctl net.ipv4.ip_forward # Deve aparecer se está configurado com a opção "1"

#"Inserir as regras, se faltar..."
#sudo sh /etc/iptables/add-openvpn-rules.sh
#sudo sysctl -w net.ipv4.ip_forward=1

echo "Verificando se o servidor OpenVPN está em execução e a porta está aberta..."
sleep 5

netstat -tulpn | grep :"$PORT" # Porta configurada para o OpenVPN
ss -tulpn | grep :"$PORT" # Porta configurada para o OpenVPN
ps aux | grep openvpn | head -n1 # Linha completa do Serviço OpenVPN
ps -C openvpn # Serviço OpenVPN
pidof openvpn # PID OpenVPN

#Se não estiver sendo executado:
#systemctl start openvpn-server@server.service
#systemctl status openvpn-server@server.service

echo "Testando se o Servidor VPN aceita conexões..."
echo "Aperte CTRL+C para sair do comando."
nc -vu "$IP" "$PORT" # IP do sistema e a porta configurada (igual telnet)

####

#Importar um arquivo .ovpn com a GUI do Network Manager:

#1) Instale o plugin OpenVPN (Debian/Ubuntu):

#apt install network-manager-openvpn-gnome openvpn-systemd-resolved

#2) Abra Network Manage r na opção Gnome settings e selecione a aba Network e clique no símbolo VPN + 
#3) Na janela Adicionar VPN , clique na opção “ Importar do arquivo… ”
#4) Você deve navegar até seu arquivo .ovpn e clicar no botão Abrir
#5) Clique no botão Adicionar
#6) Finalmente, clique no botão desligar para ligar a VPN


