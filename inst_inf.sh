#!/bin/bash
# Fonte:
# https://www.mariolb.com.br/blog/2014/05/30/como_saber_quando_um_sistema_linux_foi_instalado.html
dumpe2fs $(mount | grep "on \/ ") | grep -i "Filesystem created"
