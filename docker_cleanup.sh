#!/bin/sh

echo "Starting Docker cleanup"

if [ $(docker ps --no-trunc -aq | wc -l) -gt 0 ]
then
    echo "Cleaning up old containers"
    docker rm $(docker ps --no-trunc -aq)
else
    echo "No old containers found"
fi

if [ $(docker images -q --filter "dangling=true" | wc -l) -gt 0 ]
then
    echo "Cleaning up old images"
    docker images -q --filter "dangling=true" | xargs docker rmi
else
    echo "No old images found"
fi

echo "Docker cleanup complete"
