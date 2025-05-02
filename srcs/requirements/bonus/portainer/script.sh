#!/bin/bash

PASS=$(cat /run/secrets/portainer_usr_pass)
PORTI_PASS=$(htpasswd -nbBC 10 "" "$PASS" | tr -d ':\n')

chown -R 1000:1000 /data

# this is the first time run porttainer ::
if [ ! -f /data/portainer.db ]; then
  curl -L https://github.com/portainer/portainer/releases/download/2.16.1/portainer-2.16.1-linux-amd64.tar.gz -o /portainer.tar.gz
  tar xzf /portainer.tar.gz 
  mv -f portainer /usr/local/bin/
  rm /portainer.tar.gz
  chmod +x /usr/local/bin/portainer/portainer
  /usr/local/bin/portainer/portainer --admin-password="$PORTI_PASS" --bind=0.0.0.0:7878 --data /data

# launch normally
else
  exec /usr/local/bin/portainer/portainer --bind=0.0.0.0:7878 --data /data
fi
