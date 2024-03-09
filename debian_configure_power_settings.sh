#!/bin/bash

LOGIND_CONF="/etc/systemd/logind.conf"
HANDLE_LID_SWITCH="HandleLidSwitch=ignore"

# Desativar hibernação
sudo systemctl mask systemd-hibernate.service

# Desativar suspensão
sudo systemctl mask systemd-suspend.service

# Verificar se HandleLidSwitch existe e ajustar
if [ -f "$LOGIND_CONF" ]; then
    if grep -q "^$HANDLE_LID_SWITCH" "$LOGIND_CONF"; then
        echo "HandleLidSwitch already set to ignore."
    else
        sudo sed -i "/^#*\s*HandleLidSwitch/c$HANDLE_LID_SWITCH" "$LOGIND_CONF"
        echo "HandleLidSwitch set to ignore."
    fi
else
    echo "$LOGIND_CONF not found."
fi

# Recarregar as configurações do systemd
sudo systemctl daemon-reload

echo "Configurações de hibernação e suspensão desativadas e HandleLidSwitch configurado."
