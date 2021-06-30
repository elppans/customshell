#!/bin/bash

# Adicionar a seguinte linha no arquivo "/etc/crontab":

#*/20   *  *  *  *  root /usr/bin/mover_arquivos.sh

# Dar restart no serviço:

# systemctl restart crond.service

min=5
extension=".*"
path='/Public/TESTE'
to='/Public/TESTE2'

find $path -maxdepth 1 -name "*"$extension""  -type f -mmin +$min -exec mv '{}' "$to" \;
