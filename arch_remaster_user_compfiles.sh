#!/bin/bash

if [ $(id -u) == 0 ]; then
    echo "Não execute $(basename "$0") como Super Usuário!"
    exit 1
fi

tar -zcvf arch_remaster_user_bin.tgz .local/bin


tar -zcvf arch_remaster_user_applications.tgz .local/share/applications/DescansoPDV-Config.desktop \
.local/share/applications/NetworkManager-VPN.desktop \
.local/share/applications/RtgAtualizaBD.desktop \
.local/share/applications/SomavendaSAT.desktop \
.local/share/applications/VPN_RODRAF.desktop \
.local/share/applications/VPN_SOL.desktop \
.local/share/applications/xterm-beiraalta-penalva.desktop \
.local/share/applications/xterm-beiraalta.desktop

rm -rf .openfortigui/logs/*
tar -zcvf _openfortigui.tgz .openfortigui
sed -i "/aesiv/s/$(grep aesiv .openfortigui/main.conf | cut -d "=" -f "2")//" .openfortigui/main.conf
sed -i "/aeskey/s/$(grep aesiv .openfortigui/main.conf | cut -d "=" -f "2")//" .openfortigui/main.conf
sed -i "/username/s/$(grep username .openfortigui/vpnprofiles/VPN\ Roldao.conf | cut -d "=" -f "2")//" .openfortigui/vpnprofiles/VPN\ Roldao.conf
sed -i "/password/s/$(grep password .openfortigui/vpnprofiles/VPN\ Roldao.conf | cut -d "=" -f "2")//" .openfortigui/vpnprofiles/VPN\ Roldao.conf
tar -zcvf arch_remaster_user_openfortigui.tgz .openfortigui
tar -zxvf _openfortigui.tgz
rm -rf _openfortigui.tgz



