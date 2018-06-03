#!/bin/bash

# http://people.canonical.com/~kernel/info/kernel-version-map.html
# Fonte:
#http://ubuntuhandbook.org/index.php/2017/02/install-kernel-4-10-ubuntu-linux-mint/
#https://askubuntu.com/questions/257617/how-can-i-upgrade-the-ubuntu-lts-kernel-to-newer
#https://ubuntuforum-br.org/index.php?topic=95780.0


#KERNELREPO=http://kernel.ubuntu.com/~kernel-ppa/mainline/
#SYS=i386
#VERSION=v4.4.10-xenial
#KALL=linux-headers-4.4.10-040410_4.4.10-040410.201605110631_all.deb
#KHEAD=linux-headers-4.4.10-040410-generic_4.4.10-040410.201605110631_
#KIMG=linux-image-4.4.10-040410-generic_4.4.10-040410.201605110631_
##KEX=

#mkdir -p /tmp/kernel
#cd /tmp/kernel
#wget -c "$KERNELREPO$VERSION/$KALL"
#wget -c "$KERNELREPO$VERSION/$KHEAD$SYS".deb
#wget -c "$KERNELREPO$VERSION/$KIMG$SYS".deb
##wget -c "$KERNELREPO$VERSION"/linux-image-extra-VERSION-NUMBER_"$SYS".deb

#Opcional:
#https://www.ubuntuupdates.org/ppa/canonical_kernel_team?dist=trusty
#sudo add-apt-repositório ppa: canonical-kernel-team / ppa 
#sudo apt-get update

#linux-headers-VERSION-NUMBER_all.deb
#linux-headers-VERSION-NUMBER_amd64.deb
#linux-image-VERSION-NUMBER_amd64.deb
#linux-image-extra-VERSION-NUMBER_amd64.deb



#wget https://raw.githubusercontent.com/elppans/customshell/master/old_releases-ub.sh
#chmod +x old_releases-ub.sh
#./old_releases-ub.sh

#echo -e '# Trusty
#deb http://security.ubuntu.com/ubuntu trusty-security main' | tee /etc/apt/sources.list.d/trusty.list >> /dev/null

# KMOD Precise
sudo add-apt-repository -y ppa:allgi/ppa

# Kernel
echo -e '# Xenial
deb http://archive.ubuntu.com/ubuntu xenial main
deb http://security.ubuntu.com/ubuntu xenial-security main universe' | tee /etc/apt/sources.list.d/xenial.list >> /dev/null

apt-get update
aptitude install -t precise kmod
apt-get install --reinstall linux-firmware
apt-get install linux-base
apt-get install module-init-tools
apt-get install linux-headers-4.15.0-20 linux-headers-4.15.0-20-generic linux-image-4.15.0-20-generic linux-modules-4.15.0-20-generic
apt-get install linux-modules-extra-4.15.0-20-generic
#update-initramfs -d -k 4.15.0-20-generic
#update-initramfs -c -k 4.15.0-20-generic
#update-initramfs -u -k 4.15.0-20-generic

#linux-tools-4.15.0-20-generic

##WARNING: could not open /tmp/mkinitramfs_lRK8Cr/lib/modules/4.15.0-20-generic/modules.builtin: No such file or directory

# Remover Kernels antigos e fixar a versão 4:
wget https://raw.githubusercontent.com/elppans/customshell/master/purge-kernels-antigos -O /usr/bin/purge-kernels-antigos
chmod +x /usr/bin/purge-kernels-antigos
purge-kernels-antigos

sed -i "s/deb/#deb/g" /etc/apt/sources.list.d/xenial.list

#mkdir -p /tmp/mkinitramfs_XktXka/lib/modules/`uname -r`
#touch /tmp/mkinitramfs_XktXka/lib/modules/`uname -r`/modules.builtin

# Reinstalação do ubiquity e remastersys
#add-apt-repository -y ppa:mutse-young/remastersys

apt-get update

#apt-get purge ubiquity
#apt-get -y autoremove
#rm -rf /usr/share/ubiquity
#apt-get install syslinux squashfs-tools
#apt-get install -t precise ubiquity-frontend-debconf
apt-get install -t precise ubiquity-frontend-gtk
#apt-get install -t precise remastersys
apt-get clean
apt-get autoclean
rm -rf /var/lib/apt/lists/*
mkdir -p /var/lib/apt/lists/partial
cd /
tar -zxvf remaster_zanthus.tgz -C /
rm -rf remaster_zanthus.tgz
remastersys backup



#PPA KMOD Precise:
#https://launchpad.net/~ximion/+archive/ubuntu/tests = 9-2~p1q = Matthias Klumpp (2012-12-01)
#https://launchpad.net/~allgi/+archive/ubuntu/ppa = 9-3ubuntu1 = ubuntu12.04.1 ~ c42.ppa1 - 	H.-Dirk Schmitt (2015-10-24)
#https://launchpad.net/~jblgf0/+archive/ubuntu/outros3-precise = 9-3ubuntu1 ~ precise1 ~ ppa1 - 	H.-Dirk Schmitt (2015-06-05)
