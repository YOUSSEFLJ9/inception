#!/bin/bash



# curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose
# PORTI_PASS=$(cat /run/secrets/portainer_usr_pass)

# if [ ! -f /data/portainer.db ]; then

# curl -L https://github.com/portainer/portainer/releases/download/2.16.1/portainer-2.16.1-linux-amd64.tar.gz -o /portainer.tar.gz


# tar xzf /portainer.tar.gz 

# mv -f portainer /usr/local/bin/
# rm /portainer.tar.gz

# chmod +x /usr/local/bin/portainer/portainer
# # this is the first time run porttainer ::
# /usr/local/bin/portainer/portainer --admin-password="$PORTI_PASS" --bind=0.0.0.0:7878 --data /data &

# sleep 12

# fi

# # tail -f /dev/null


# exec /usr/local/bin/portainer/portainer --bind=0.0.0.0:7878 --data /data



# !/bin/bash

RAW_PASS=$(cat /run/secrets/portainer_usr_pass)
PORTI_PASS=$(htpasswd -nbBC 10 "" "$RAW_PASS" | tr -d ':\n')
# Install docker-compose if needed
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

chown -R 1000:1000 /data
# Download Portainer if not already set up
if [ ! -f /data/portainer.db ]; then
  curl -L https://github.com/portainer/portainer/releases/download/2.16.1/portainer-2.16.1-linux-amd64.tar.gz -o /portainer.tar.gz
  tar xzf /portainer.tar.gz
  mv -f portainer /usr/local/bin/
  rm /portainer.tar.gz
  chmod +x /usr/local/bin/portainer/portainer

  # First-time launch to create admin
  /usr/local/bin/portainer/portainer \
    --admin-password="$PORTI_PASS" \
    --bind=0.0.0.0:7878 \
    --data /data

else
  # Just launch normally
  exec /usr/local/bin/portainer/portainer --bind=0.0.0.0:7878 --data /data
fi
