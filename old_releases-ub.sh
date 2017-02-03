#!/bin/bash
cp -rfv /etc/apt/sources.list /etc/apt/sources.list.bkp_`date +%Y%m%d%H%M%S`

echo "
## End-of-Line (EOL) upgrade sources.list

# Old Ubuntu Releases
# http://old-releases.ubuntu.com/releases/
# Old repositories:
# http://old-releases.ubuntu.com/ubuntu/

# Required
deb http://old-releases.ubuntu.com/ubuntu/ `lsb_release -cs` main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ `lsb_release -cs`-updates main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ `lsb_release -cs`-security main restricted universe multiverse

# Optional
#deb http://old-releases.ubuntu.com/ubuntu/ `lsb_release -cs`-backports main restricted universe multiverse
" | sudo tee /etc/apt/sources.list
