#!/bin/bash
#set -x
srcname=hcvdocker.azurecr.io
destname=mosipstaging.azurecr.io
echo loging into $srcname
sudo docker login $srcname
cat dockerlist.txt | while read file
do
echo processing $file
sudo docker pull $srcname/$file
sudo docker tag $srcname/$file $destname/$file
done

sudo docker logout $srcname


