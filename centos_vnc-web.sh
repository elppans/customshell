#!/bin/bash

#https://kanaka.github.io/noVNC/

yum updateinfo
yum -y install git
mkdir -p /usr/share/kanaka-noVNC
git clone git://github.com/kanaka/noVNC /usr/share/kanaka-noVNC
git clone https://github.com/novnc/websockify /usr/share/kanaka-noVNC/utils/websockify
cat >/usr/bin/novnc<<EOF
#!/bin/bash
cd /usr/share/kanaka-noVNC/utils/
./launch.sh "\$@"
EOF
chmod +x /usr/bin/novnc
mkdir -p /usr/share/kanaka-noVNC/web
cp -rfv /usr/share/kanaka-noVNC/vnc*.html /usr/share/kanaka-noVNC/web/
#/usr/bin/novnc --web /usr/share/kanaka-noVNC/web/

yum -y install x11vnc
x11vnc -storepasswd

cat >/usr/bin/x11vnc-browser<<EOF
#!/bin/bash
x11vnc -forever -auth guess -cursor arrow -shared -rfbport 5900 -rfbauth /root/.vnc/passwd -noxdamage 2>&1 1>& /var/log/x11vnc.log &
/usr/bin/novnc --listen 6080 --vnc localhost:5900 --web /usr/share/kanaka-noVNC/web/ 2>&1 1>& /var/log/noVNC.log &
iptables -I INPUT -p tcp --dport 6080 -j ACCEPT
iptables -nL |grep 6080
EOF
chmod +x /usr/bin/x11vnc-browser

sudo touch /etc/systemd/system/x11vnc-browser.service
sudo chmod 664 /etc/systemd/system/x11vnc-browser.service

cat >/etc/systemd/system/x11vnc-browser.service<<EOF
[Unit]
Description=x11vnc-browser
Requires=network.target
After=network.target
[Service]
Type=forking
ExecStart=/usr/bin/x11vnc-browser
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start x11vnc-browser.service
systemctl enable x11vnc-browser.service

#

# Backup:
cd /opt
tar -zcvf kanaka-novnc_git-`date +%d%m%y`.tgz /usr/share/kanaka-noVNC /usr/bin/novnc /usr/bin/x11vnc-browser /etc/systemd/system/x11vnc-browser.service
