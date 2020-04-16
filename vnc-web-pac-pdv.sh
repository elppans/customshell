#!/bin/bash

#https://kanaka.github.io/noVNC/
wget -c https://www.dropbox.com/s/ta0xtm5rnyzjznu/kanaka-novnc_git-040220.tgz
tar -zxvf kanaka-novnc_git-040220.tgz -C /

sudo apt-get update
sudo apt-get install x11vnc
x11vnc -storepasswd

systemctl daemon-reload
systemctl start x11vnc-browser.service
systemctl enable x11vnc-browser.service
systemctl status x11vnc-browser.service
