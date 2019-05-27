#!/bin/bash
#set -x
destname=mosipstaging.azurecr.io
sudo docker login $destname
cat dockerlist.txt | while read file
do
echo processing $file
sudo docker push $destname/$file
done

sudo docker logout

sudo docker rmi -f $(sudo docker images | grep $destname/)
