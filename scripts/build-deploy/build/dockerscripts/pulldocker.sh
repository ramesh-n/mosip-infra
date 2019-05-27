#!/bin/bash
#set -x
srcname=hcvdocker.azurecr.io
echo login into $srcname
sudo docker login $srcname
cat dockerlist.txt | while read file
do
echo processing $file
sudo docker pull $srcname/$file
echo processed  $file
done

sudo docker logout $srcname


