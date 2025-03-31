#!/bin/bash

# Blockear/Remover o Caps Lock
setxkbmap -option ctrl:nocaps
xmodmap -e "remove lock = Caps_Lock"
xmodmap -e "keycode 66 = NoSymbol"

#___

# Ativar/Desativar o Caps Lock

xdotool key Caps_Lock
