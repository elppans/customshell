 
#!/bin/bash

# Distro recomendada: Manjaro e derivados na versão 21.0.5+
# Repositório recomendado: AUR

if [ $(id -u) == 0 ]; then
    echo "NÃO execute $(basename "$0") como Super Usuário!"
    exit 1
fi

## Sincronização de horário:

sudo ntpdate a.ntp.br && sudo hwclock -w

cd

# variavel para comandos em $HOME

mkdir -p ~/.local/bin
grep "$HOME/.local/bin" ~/.bashrc || echo -e 'export PATH="$PATH:$HOME/.local/bin"' | tee -a ~/.bashrc

## Atualização dos repositórios

sudo apt update

## fakeroot

sudo apt -y install fakeroot

##	PACOTES

# Compartilhamentos

sudo apt -y install samba smbclient cifs-utils gvfs* sshfs winbind nfs-common fusesmb

#sudo mkdir -p /var/lib/samba/usershares
#sudo chmod 1770 /var/lib/samba/usershares
#sudo chown .sambashare /var/lib/samba/usershares
sudo usermod -a -G sambashare $USER
sudo usermod -a -G nogroup $USER
sudo sed -i '/user_allow_other/s/#//' /etc/fuse.conf

# Pacotes CLI

sudo apt -y install numlockx
sudo apt -y install git subversion
sudo apt -y install sshpass

# Acessos

sudo apt -y install putty openssh-server
sudo apt -y install remmina* libvncclient1 libvncserver1
mkdir -p ~/.local/share/remmina

# Terminais

# Yakuake. Terminal Suspenso KDE
#sudo pacman -S --needed --noconfirm yakuake
#sudo pacman -S --needed --noconfirm konsole
sudo apt -y install xterm

# Edição de imagens

sudo apt -y install imagemagick gimp

# Edição de textos

sudo apt -y install kate

# Java
java --version && echo "java OK!" || sudo apt -y install default-jdk

# NetworkManager VPN

# network-manager-l2tp-gnome network-manager-openconnect-gnome

rm -rf ~/.local/share/keyrings/*

sudo apt -y install network-manager*-gnome
sudo systemctl stop xl2tpd
sudo systemctl disable xl2tpd
sudo systemctl restart ipsec
#sudo systemctl restart NetworkManager # Movido para o final do arquivo

# Pacotes AUR
# Distro release openfortigui (para caso tenha problemas com o padrão adicionado)
OFGRELEASE=focal

sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2FAB19E7CCB7F415
wget -c https://apt.iteas.at/iteas/dists/$(lsb_release -cs)/InRelease -O /tmp/InRelease && \
echo -e "deb https://apt.iteas.at/iteas $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/iteas.list || \
echo -e "deb https://apt.iteas.at/iteas "$OFGRELEASE" main" | sudo tee /etc/apt/sources.list.d/iteas.list
sudo apt update && sudo apt -y install libqt5keychain1 openfortigui
mkdir -p ~/.openfortigui/vpngroups ~/.openfortigui/vpnprofiles ~/.openfortigui/logs/vpn

# PlayOnLinux
sudo apt -y install playonlinux wine64 winetricks

#sudo pacman -S --needed --noconfirm wine-staging
#sudo pacman -S --needed --noconfirm winetricks
#pamac build --no-confirm playonlinux


##	Porta serial no Wine:

sudo usermod -a -G dialout $USER

# Browser

sudo apt -y install chromium-browser
#sudo apt -y install midori
sudo apt -y install libgcc1 # https://vivaldi.com/pt-br/download/
# https://forum.vivaldi.net/topic/42382/no_pubkey-error
#curl https://repo.vivaldi.com/stable/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/vivaldi-browser.gpg
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 793FEB8BB69735B2
#sudo gpg --keyserver pgpkeys.mit.edu --recv-key  793FEB8BB69735B2
#sudo gpg -a --export 793FEB8BB69735B2 | sudo apt-key add -
#gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv 793FEB8BB69735B2
#gpg --export --armor 793FEB8BB69735B2 | sudo apt-key add -
wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
echo -e 'deb [arch=amd64] http://repo.vivaldi.com/stable/deb/ stable main' | sudo tee /etc/apt/sources.list.d/vivaldi.list && sudo apt update
sudo apt install vivaldi-stable
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
echo -e 'deb https://deb.opera.com/opera-stable/ stable non-free' | sudo tee /etc/apt/sources.list.d/opera-stable.list && sudo apt update
sudo apt -y install opera-stable
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
sudo install -o root -g root -m 644 /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/ && sudo rm /tmp/microsoft.gpg
echo -e 'deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list && sudo apt update
sudo apt -y install microsoft-edge-stable


##  OUTROS

# complemento typora (Editor Markdown simples):

#sudo pacman -S --needed --noconfirm pandoc
#pamac build --no-keep --no-confirm typora
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt -y install typora pandoc
cp -av /usr/share/applications/typora.desktop ~/.local/share/applications/
###

## Gerenciador de banco de dados dbeaver:
# https://dbeaver.io/download/

sudo add-apt-repository ppa:serge-rider/dbeaver-ce
sudo apt update
sudo apt -y install dbeaver-ce

# apt-file
 ! dpkg -l apt-file | grep ^ii && \
        {
        echo OK
sudo apt-get -y install apt-file && sudo apt-file update || echo "apt-file não instalado!"
}

# gnome-shell-extension-appindicator
# https://github.com/ubuntu/gnome-shell-extension-appindicator

sudo apt -y install ninja-build meson
mkdir -p ~/Downloads/build && cd ~/Downloads/build
git clone https://github.com/ubuntu/gnome-shell-extension-appindicator.git
meson gnome-shell-extension-appindicator /tmp/g-s-appindicators-build
ninja -C /tmp/g-s-appindicators-build install
echo -e 'Deslogue e Relogue e faça o comando para ativar a extenção gnome-shell-extension-appindicator:
\tgnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
'
cd
rm -rf ~/Downloads/build

sudo systemctl restart NetworkManager


