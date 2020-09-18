#!/bin/bash

echo "-1" | tee /sys/module/usbcore/parameters/autosuspend
echo "-1" | tee /sys/bus/usb/devices/usb*/power/autosuspend
echo "-1" | tee /sys/bus/usb/devices/usb*/power/autosuspend_delay_ms
echo "on" | tee /sys/bus/usb/devices/usb*/power/control

sed -i "s/exit 0//g" /etc/rc.local
sed -i "s/.\/startup &//g" /etc/rc.local
echo -e '
  echo "usbcore on"
echo "-1" | tee /sys/module/usbcore/parameters/autosuspend >> /dev/null
echo "-1" | tee /sys/bus/usb/devices/usb*/power/autosuspend >> /dev/null
echo "-1" | tee /sys/bus/usb/devices/usb*/power/autosuspend_delay_ms >> /dev/null
echo "on" | tee /sys/bus/usb/devices/usb*/power/control >> /dev/null
\n\nexit 0
' | sudo tee -a /etc/rc.local
sed -i '/exit/i ./startup &'  /etc/rc.local
echo "options usbcore autosuspend=-1" | sudo tee /etc/modprobe.d/disable-usb-autosuspend.conf > /dev/null

sed -i "/GRUB_CMDLINE_LINUX_DEFAULT/s/quiet/quiet net.ifnames=0 biosdevname=0 usbcore.autosuspend=-1/g" /etc/default/grub
update-grub

# Fontes:
#
# https://askubuntu.com/questions/1044988/usb-ports-not-working-after-resume-from-sleep-on-ubuntu-18-04
# https://unix.stackexchange.com/questions/91027/how-to-disable-usb-autosuspend-on-kernel-3-7-10-or-above
# https://sobrelinux.info/questions/771630/how-to-disable-usb-autosuspend-on-kernel-3-7-10-or-above
# https://ubuntuforums.org/archive/index.php/t-1968487.html
# https://kodi.wiki/view/HOW-TO:Suspend_and_wake_in_Ubuntu
# https://bbs.archlinux.org/viewtopic.php?id=199504

