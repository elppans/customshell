 
#!/bin/bash

# Distro recomendada: Manjaro e derivados na versão 21.0.5+
# Repositório recomendado: AUR

if [ $(id -u) == 0 ]; then
    echo "NÃO execute $(basename "$0") como Super Usuário!"
    exit 1
fi

sudo ntpdate a.ntp.br && sudo hwclock -w

cd

# variavel para comandos em $HOME

mkdir -p ~/.local/bin
grep "$HOME/.local/bin" ~/.bashrc || echo -e 'export PATH="$PATH:$HOME/.local/bin"' | tee -a ~/.bashrc

## Atualização dos repositórios

sudo pacman -Syy

## fakeroot

sudo pacman -S --needed --noconfirm fakeroot

## pamac

if [ ! -e /usr/bin/pamac ]; then
#mkdir -p ~/build/pamac-aur
#git clone https://aur.archlinux.org/pamac-aur.git ~/build/pamac-aur
#cd ~/build/pamac-aur
#makepkg --install --syncdeps --rmdeps --needed --noconfirm --skipchecksums --skippgpcheck --clean
sudo pacman -S --needed --noconfirm pamac-cli pamac-gtk
read -p "Aperte ENTER para continuar ou CTRL+C para sair..."
fi

##	PACOTES

# Compartilhamentos

sudo pacman -S --needed --noconfirm samba cifs-utils sshfs nfs-utils

# Instalar uma lista de pacotes com "gvfs"
sudo pacman -S --needed --noconfirm $(pacman -Ssq gvfs)
sudo mkdir -p /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares
sudo chown .sambashare /var/lib/samba/usershares
sudo usermod -a -G sambashare $USER
sudo sed -i '/user_allow_other/s/#//' /etc/fuse.conf

# Pacotes CLI

sudo pacman -S --needed --noconfirm numlockx
sudo pacman -S --needed --noconfirm git subversion
sudo pacman -S --needed --noconfirm sshpass

# Acessos

sudo pacman -S --needed --noconfirm putty openssh
sudo pacman -S --needed --noconfirm x11-ssh-askpass
sudo pacman -S --needed --noconfirm remmina libvncserver freerdp
mkdir -p ~/.local/share/remmina

# Terminais

# Yakuake. Terminal Suspenso KDE
#sudo pacman -S --needed --noconfirm yakuake
#sudo pacman -S --needed --noconfirm konsole
sudo pacman -S --needed --noconfirm xterm

# Edição de imagens

sudo pacman -S --needed --noconfirm imagemagick gimp

# Edição de textos

sudo pacman -S --needed --noconfirm kate

# Java

java --version && echo "java OK!" || sudo pacman -S --needed --noconfirm jre-openjdk

# NetworkManager VPN

# network-manager-l2tp-gnome network-manager-openconnect-gnome

sudo pacman -S --needed --noconfirm $(pacman -Ssq networkmanager | grep -v -E "qt|lib32*")
sudo systemctl stop xl2tpd && sudo systemctl disable xl2tpd
#sudo systemctl restart ipsec
#sudo systemctl restart NetworkManager # Movido para o final do arquivo

# Pacotes AUR

pamac build --no-keep --no-confirm fusesmb
pamac build --no-keep --no-confirm openfortigui

# PlayOnLinux

sudo pacman -S --needed --noconfirm wine-staging
sudo pacman -S --needed --noconfirm winetricks
#pamac build --no-confirm playonlinux


##	Porta serial no Wine:

#sudo usermod -a -G dialout $USER

# Browser

#sudo pacman -S --needed --noconfirm chromium
#sudo pacman -S --needed --noconfirm midori
#sudo pacman -S --needed --noconfirm vivaldi vivaldi-ffmpeg-codecs

#pamac build --no-keep --no-confirm microsoft-edge-stable-bin

##  OUTROS

# complemento typora (Editor Markdown simples):

#sudo pacman -S --needed --noconfirm pandoc
#pamac build --no-keep --no-confirm typora

###

sudo systemctl restart NetworkManager
