#!/bin/bash

PASS=$(cat /run/secrets/portainer_usr_pass)
# hass the pass for portainer admien @ -n print to stdout -b use pass from cl non intractive, -B admin-password only accepts bcrypt hashes
# tr it used for replace or delete chars -d : delete
PORTI_PASS=$(htpasswd -nbB "" "$PASS" | tr -d ':\n')

chown -R 1000:1000 /data_pt

# this is the first time run porttainer ::
if [ ! -f /data_pt/portainer.db ]; then
  curl -L https://github.com/portainer/portainer/releases/download/2.16.1/portainer-2.16.1-linux-amd64.tar.gz -o /portainer.tar.gz
  # tar x : extrct , z : using zgip comprition, f : the file following..
  tar xzf /portainer.tar.gz 
  mv -f portainer /usr/local/bin/
  rm /portainer.tar.gz
  chmod +x /usr/local/bin/portainer/portainer
  exec /usr/local/bin/portainer/portainer --admin-password="$PORTI_PASS" --bind=0.0.0.0:7878 --data /data_pt

# launch normally
else
  exec /usr/local/bin/portainer/portainer --bind=0.0.0.0:7878 --data /data_pt
fi
