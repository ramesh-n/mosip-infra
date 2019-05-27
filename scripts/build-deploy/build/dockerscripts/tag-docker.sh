#!/bin/bash
#set -x
#srcname=hcvdocker.azurecr.io
destname=mosipstaging.azurecr.io
cat $HOME/mosip-staging/mosip-internal/scripts/dockerlist.txt | while read file
do
echo processing $file
sudo docker tag $file $destname/$file
echo processed $file
done



