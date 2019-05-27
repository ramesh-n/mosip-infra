#!/bin/bash

echo get rpm
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

echo running certbot. Please answer questions. AWAITING YOUR INPUT
sudo certbot --nginx certonly

echo Note: Update the default-https.conf file with the domain with https certificate is created using Certbot.

echo after that run the command:  sudo systemctl restart nginx
