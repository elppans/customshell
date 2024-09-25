#!/bin/bash
#  Maintainer: Eduardo Mira

# Dependência: smartmontools

# Verifica todos os dispositivos de bloco com suporte a SMART
for disk in /dev/sd?; do
    echo "Verificando $disk..."
    smartctl -H "$disk" | grep -i "status"
    echo "-----------------------------------"
done

# Verifica todos os dispositivos de bloco
for disk in /dev/sd?; do
    # Verifica se o dispositivo é um SSD
    if smartctl -i "$disk" | grep -q "Solid State Device"; then
        echo "Verificando SSD: $disk..."
        smartctl -H "$disk" | grep -i "status"
        echo "-----------------------------------"
    else
        echo "$disk não é um SSD, pulando..."
    fi
done
