#!/bin/sh
# https://github.com/Trellmor/bind-adblock


cd /etc/bind/bind-adblock
python ./update-zonefile.py --no-bind /etc/bind/pri/blacklist.zone blacklist.zone
chown named:named /etc/bind/pri/blacklist.zone
restorecon /etc/bind/pri/blacklist.zone
rndc reload
