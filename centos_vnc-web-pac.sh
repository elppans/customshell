#!/bin/bash

#https://kanaka.github.io/noVNC/
#wget -c https://www.dropbox.com/s/ta0xtm5rnyzjznu/kanaka-novnc_git-040220.tgz
wget -c https://github.com/elppans/conf/raw/master/novnc_web/kanaka-novnc_git-040220.tgz
tar -zxvf kanaka-novnc_git-040220.tgz -C /

yum updateinfo
yum -y install x11vnc
x11vnc -storepasswd

systemctl daemon-reload
systemctl start x11vnc-browser.service
systemctl enable x11vnc-browser.service
systemctl status x11vnc-browser.service
