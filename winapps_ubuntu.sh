#!/bin/bash

# https://github.com/Fmstrat/winapps
# https://plus.diolinux.com.br/t/material-de-apoio-winapps-linux-kvm-rdp/27596?u=elppans
# https://www.youtube.com/watch?v=d562WVyLPVM

# Seguir as instruções para a configuração da máquina virtual que está escrito no final deste Shell Script simples

## Usuário
echo -e "Digite o nome de usuário que será usado no RDPWindows e aperte ENTER"
read -p "Usuário: " USUARIO

## Senha (*)
echo -e "Digite a senha que será usada no RDPWindows e aperte ENTER..."
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
        stty -echo
        echo "$password" >> /dev/null
        SENHA="$password"
        stty echo

	echo "Atualizando o repositório e instalando as dependências..."
	
	sudo apt update -qq
	sudo apt install -y freerdp2-x11
	sudo apt install -y virt-manager
	sudo apt install -y git

mkdir -p ~/.local/bin
mkdir -p ~/.config/winapps

cat << 'EOF' > ~/.config/winapps/winapps.conf
RDP_USER="MyWindowsUser"
RDP_PASS="MyWindowsPassword"
#RDP_DOMAIN="MYDOMAIN"
#RDP_IP="192.168.123.111"
#RDP_SCALE=100
#RDP_FLAGS=""
#MULTIMON="true"
#DEBUG="true"
EOF

cat << 'EOF' > ~/.local/bin/winapps-run
#!/bin/bash
cd ~/.config/winapps/winapps
./installer.sh "$@"
EOF
chmod +x ~/.local/bin/winapps-run
sed -i "s/MyWindowsUser/"$USUARIO"/g" ~/.config/winapps/winapps.conf
sed -i "s/MyWindowsPassword/"$SENHA"/g" ~/.config/winapps/winapps.conf
cd ~/.config/winapps

git clone https://github.com/Fmstrat/winapps.git
cd winapps
cd ~/.config/winapps/winapps/kvm
#wget -c https://raw.githubusercontent.com/Fmstrat/winapps/main/kvm/RDPWindows.qcow2
#wget -c https://raw.githubusercontent.com/Fmstrat/winapps/main/kvm/RDPWindows.xml
wget -c https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
cd -

sudo sed -i "s/#user = \"root\"/user = \""$(id -un)"\"/g" /etc/libvirt/qemu.conf
sudo sed -i "s/#group = \"root\"/group = \""$(id -gn)"\"/g" /etc/libvirt/qemu.conf
sudo usermod -a -G kvm $(id -un)
sudo usermod -a -G libvirt $(id -un)
#sudo usermod -a -G libvirt-qemu $(id -un)
#sudo usermod -a -G libvirt-dnsmasq $(id -un)
getent group kvm
getent group libvirt
sudo systemctl stop libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd
sudo ln -s /etc/apparmor.d/usr.sbin.libvirtd /etc/apparmor.d/disable/
#ln -sf ~/.config/winapps/winapps/bin/winapps ~/.local/bin/winapps
sudo ln -sf ~/.config/winapps/winapps/bin/winapps /usr/local/bin/
sudo virsh net-autostart default
sudo virsh net-start default 2>> /dev/null
sudo virsh net-info default
virsh define kvm/RDPWindows.xml
virsh autostart RDPWindows
virsh list --all

read -t 5
clear

echo -e '
Ao criar uma Máquina Virtual para usar o "WinApps for Linux", DEVE usar o nome RDPWindows e instalar o Windows 10 PRO.
Após instalar o Windows, habilite a Área de trabalho remota (RDP) e depois faça o comando "winapps check" para verificar se o FreeRDP pode se conectar.
Foi adicionado para o usuário o comando winapps-run, ao executar, o mesmo irá até a pasta winapps e executará o Script "installer.sh" automaticamente.
Para mais informações, acesse "https://github.com/Fmstrat/winapps"!
O Sistema DEVE ser reiniciado para usar o virt-manager...
'
for i in `seq 20 -1 1` ; do
 echo -ne " Aperte \"CTRL+C\" para continuar usando o sistema OU espere $i SEGUNDOS para reiniciar\r"
  sleep 1
done

sudo reboot

###	Instalar/Editar Máquina Virtual:

# 0) Siga as instruções deste link desde o começo OU siga as instruções posteriores:
#	https://github.com/Fmstrat/winapps/blob/main/docs/KVM.md

# 1) Em "Editar > Preferências", habilitar a opção "Enable XML editing"

# 2) Selecione RDPWindows e vá em "Editar > Detalhes da Máquina Virtual"

# 3) Em "Visão Geral", aba XML, procure a linha:

# 	<source file="./RDPWindows.qcow2"/>

# E coloque o caminho completo e depois clique em "Aplicar", exemplo:

# 	<source file="/home/USUARIO/.config/winapps/winapps/kvm/RDPWindows.qcow2"/>
	
# Ps.: USUARIO = Nome da pasta do usuário usado no sistema.

# 4) Em "CPUs", selecione a opção "Copiar configuração da CPU do host"

# 5) Em "SATA CDROM 1" selecione a sua ISO

# 6) Em "SATA CDROM 2", aba XML, procure a linha:

# 	<source file="./virtio-win-0.1.185.iso"/>

# E coloque o caminho completo e depois clique em "Aplicar", exemplo:

# 	<source file="/home/USUARIO/.config/winapps/winapps/kvm/virtio-win.iso"/>
	
# Ps.: Veja se tem o arquivo "virtio-win.iso" na pasta kvm, se não tiver, baixe.

# 7) Siga as instruções deste link: https://github.com/Fmstrat/winapps/blob/main/docs/KVM.md#install-the-virtual-machine

# 8) Após a instalação, não esqueça de renomear o nome do sistema para "RDPWindows", Habilitar a "Área de trabalho remota" e adicionar o registro baixado deste link:
# 	https://github.com/Fmstrat/winapps/blob/main/install/RDPApps.reg

# 9) Após a instalação e configuração, não é mais necessário usar este comando:

# xfreerdp /d: /u:USER /p:PASSWORD /v:IPADDRESS

# Faça o seguinte comando:

# winapps check

# Depois para instalar/verificar os Apps, faça:

# cd ~/.config/winapps/winapps
#  ./installer.sh --user
 
# OU use o comando criado pelo Script:

# winapps-run
