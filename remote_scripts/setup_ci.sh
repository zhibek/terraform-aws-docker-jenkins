#!/bin/bash

while [ `sudo lsblk -n | grep -c 'xvdh'` -ne 1 ]
do
    echo "Waiting for /dev/xvdh to become available"
    sleep 10
done

if [ `sudo file -s /dev/xvdh | grep -c ext4` == 0 ]
then
    echo "New volume - formatting /dev/xvdh"
    sudo mkfs.xfs /dev/xvdh
fi

echo "Mounting /dev/xvdh as /data"
sudo mkdir /data
sudo mount /dev/xvdh /data

echo "Updating system and installing Docker"
sudo apt-get update
sudo apt-get -y install curl
curl -sSL https://get.docker.com/ | sudo sh

echo "Starting Docker with jenkinsci/blueocean image"
sudo docker run -d \
-u root \
-p 8080:8080 \
-p 50000:50000 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /data:/var/jenkins_home \
jenkinsci/blueocean
