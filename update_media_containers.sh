#!/bin/bash
#Script that cron runs to stop containers, prune images and pull the latest ones.
# What the heck is Watchtower

set -x

echo '----Today is: '$(date +%d%m%Y)'----'

#Stop all running containers
echo 'Stopping all running containers...'
docker stop $(docker ps -qa)

#Remove all running containers
echo 'removing containers...'
docker rm $(docker ps -qa)

#Prune images
echo 'Pruning all images...'
docker image prune -a -f

#Run this docker-compose file to pull latest images and restart containers
echo 'Grabbing new images and restarting containers...'
docker-compose -f /opt/scripts/media.yml up -d 2>&1

echo '---- Updates Complete! ----\n'
