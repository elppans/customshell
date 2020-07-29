#!/bin/bash

#echo "Preparando para executar o comando..."

#yum -y install sshpass  >> /dev/nul 2>&1 &
#apt-get -y install sshpass   >> /dev/nul 2>&1 &

for IP in $(cat teste_ip.txt);
do
#echo "Testando IP $IP";
if ping -c 1 "$IP" >> /dev/null; then
        echo ""$IP" OK!"
else
        echo -e ""$IP" OFF!"
fi

done
