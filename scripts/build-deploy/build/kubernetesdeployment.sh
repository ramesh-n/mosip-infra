#!/bin/bash

echo kubernetes deployment scripts

echo deploying kernel components
echo deleteing the deployment scripts
printf "\n=====================================================================\n"
printf "\n\n deleting kernel\n\n"
kubectl delete -f $HOME/mosip-staging/static-change/scripts/kubernetes/kernel-deployment/
printf "\n=====================================================================\n"
printf "\n\n deleting pre-reg\n\n"
kubectl delete -f $HOME/mosip-staging/static-change/scripts/kubernetes/pre-registration-deployment/

echo deploying of new pods with the latest containers
printf "\n=====================================================================\n"
printf "\n\n deploying kernel\n\n"

kubectl apply -f $HOME/mosip-staging/static-change/scripts/kubernetes/kernel-deployment/

sleep 10

printf "\n=====================================================================\n"
printf "\n\n deploying pre-reg\n\n"

kubectl apply -f $HOME/mosip-staging/static-change/scripts/kubernetes/pre-registration-deployment/
printf "\n=====================================================================\n"
echo logining to keymanager server

ssh -t mosip-open@mosip-staging-keymanager.centralus.cloudapp.azure.com << EOF

echo stopping the keymanager container and removing it 
echo Mosipopen@123 | sudo -S docker stop $(docker ps -a -q)
sudo docker rm $(docker ps -a -q)

echo Logining into the docker registory.

sudo docker login mosipstaging.azurecr.io -u mosipstaging -p jg3uClHttkE0m+dpWxoqjMjQcGyNKBKb   

echo stopping the docker servicec and removing it
sudo docker kill kernel-keymanager-service

sudo docker rm kernel-keymanager-service

echo pulling the new container from the registory.

sudo docker pull mosipstaging.azurecr.io/kernel-keymanager-service

echo creating the keymanager container.

echo Mosipopen@123| sudo -S docker run -tid --ulimit memlock=-1  -p 8088:8088 -e spring_config_url_env=https://mosip-staging-test.eastus.cloudapp.azure.com/config -e spring_config_label_env=master -e active_profile_env=qa -v softhsm:/softhsm --name kernel-keymanager-service mosipstaging.azurecr.io/kernel-keymanager-service
sudo docker ps

exit

EOF

sleep 30

printf "\n=====================================================================\n"
kubectl delete pods --field-selector=status.phase!=Running
printf "\n=====================================================================\n"
echo deployement is completed.


