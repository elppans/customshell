#!/bin/bash

echo -e "Digite a senha do usuário ftp e aperte ENTER..."
        unset password
        prompt="password:"
        while IFS= read -p "$prompt" -r -s -n 1 char
        do
            if [[ $char == $'\0' ]]
            then
                 break
            fi
            prompt='*'
            password+="$char"
        done
echo -e "\n\n"

wget --user pdvtec --password="$password" -c ftp://ftp.zanthus.com.br:2142/parceiros/pdvtec/zpath/zpath_info.txt
