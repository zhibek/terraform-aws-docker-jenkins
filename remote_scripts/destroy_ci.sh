#!/bin/bash

echo "Stop Docker"
sudo docker stop $(sudo docker ps -q)

echo "Unmounting /dev/xvdh as /data"
sudo umount /dev/xvdh
