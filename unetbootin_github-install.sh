#!/bin/bash

# Criar pendrive bootável com Unetbootin
# sudo apt purge usb-creator-gtk usb-creator-common
# sudo apt purge gnome-multi-writer

# UNetbootin must be run as root. Run it from the command line using:
# https://github.com/unetbootin/unetbootin
sudo apt -y install mtools
sudo curl -JLk -o "/usr/local/bin/unetbootin-linux64.bin" https://github.com/unetbootin/unetbootin/releases/download/702/unetbootin-linux64-702.bin
sudo chmod +x "/usr/local/bin/unetbootin-linux64.bin"
echo -e '#!/bin/bash
gnome-terminal -e "sudo -S QT_X11_NO_MITSHM=1 /usr/local/bin/unetbootin-linux64.bin"
' | sudo tee /usr/local/bin/unetbootin >>/dev/null
sudo chmod +x /usr/local/bin/unetbootin
echo -e '[Desktop Entry]
Version=1.0
Type=Application
Name=UNetbootin
Comment=Criar pendrives bootáveis com UNetbootin
Exec=/usr/local/bin/unetbootin
Icon=drive-usb
Terminal=false
Categories=System;Utility;
StartupNotify=true
' | tee "$HOME"/.local/share/applications/unetbootin.desktop
chmod +x "$HOME"/.local/share/applications/unetbootin.desktop
