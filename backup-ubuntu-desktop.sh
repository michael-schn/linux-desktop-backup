#!/bin/bash 

# Destination to the backup server 
DEST="backupuseraccount@192.168.122.10:/srv/ubuntu-OS-backups/"

rsync -a \
  --exclude='.cache' \
  --exclude='/etc/shadow*' \
  --exclude='/etc/gshadow*' \
  --exclude='/etc/security/opasswd' \
  --exclude='/etc/ssh/ssh_host_*_key' \
  --exclude='/etc/ssl/private/' \
  --exclude='/etc/NetworkManager/system-connections/' /home/michael /etc /usr/local "$DEST" 
