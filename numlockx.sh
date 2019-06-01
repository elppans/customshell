#!/bin/bash

 ! dpkg -l numlockx | grep ^ii >> /dev/null &&
	{
	sudo apt update
	sudo apt -y install numlockx
}

echo -e "#/bin/bash\n\nnumlockx on\n" | sudo tee /usr/bin/numlockx_on >> /dev/null
sudo chmod +x /usr/bin/numlockx_on


mkdir -p ~/.config/autostart
touch ~/.config/autostart/numlockx_on.desktop

cat >> ~/.config/autostart/numlockx_on.desktop<<EOF
[Desktop Entry]
Type=Application
Exec=xterm -e numlockx_on
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[pt_BR]=numlockx_on
Name=numlockx_on
Comment[pt_BR]=
Comment=
EOF
