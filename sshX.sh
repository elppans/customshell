#!/bin/bash

yum -y install "@Fonts" xauth
echo -e "\nPort 22\nProtocol 2\nPermitRootLogin yes\nX11Forwarding yes" | tee -a /etc/ssh/sshd_config
systemctl restart sshd.service
