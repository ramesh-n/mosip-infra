#!/bin/bash
echo Creating /etc/yum.repos.d/nginx.repo file
printf "[nginx]\n	name=nginx repo\n	baseurl=http://nginx.org/packages/mainline/rhel/7/$basearch/\n	gpgcheck=0\n	enabled=1\n" >  /etc/yum.repos.d/nginx.repo

echo installing nginx
sudo yum install nginx

echo enabling nginx
sudo systemctl enable nginx

echo start nginx
sudo systemctl start nginx

echo enable filrewall on port 80
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent 

echo reload firewall settings
sudo firewall-cmd --reload

