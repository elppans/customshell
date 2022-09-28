#!/bin/bash

#!/bin/bash

AUR='pacotes_AUR.txt'
ls -d1 */ > "$AUR"
for PAC in $(cat "$AUR"); do
if [ -d "$PAC" >> /dev/null ] ; then
cd $(readlink -m "$PAC") &&  \
git pull origin master && \
echo "$PAC" OK || makepkg -siLCf --needed --noconfirm
cd - >> /dev/null
 else
echo -e ""$PAC" OFF!"
fi
done
