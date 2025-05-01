#!/bin/bash


curl -L https://github.com/portainer/portainer/releases/download/2.16.1/portainer-2.16.1-linux-amd64.tar.gz -o /portainer.tar.gz


tar xzf /portainer.tar.gz 

mv -f portainer /usr/local/bin/
rm /portainer.tar.gz

chmod +x /usr/local/bin/portainer/portainer

PORTI_PASS=$(cat /run/secrets/portainer_usr_pass)

if [ ! -f /data/portainer.db ]; then

# this is the first time run porttainer ::
/usr/local/bin/portainer --admin-password="$PORTI_PASS" --bind=0.0.0.0:7878 --data /data &

sleep 12

fi

# tail -f /dev/null
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


exec /usr/local/bin/portainer/portainer --bind=0.0.0.0:7878 --data /data

