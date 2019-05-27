#!/bin/bash
echo Installing postgres database server
sudo yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm

echo run update
sudo yum update

echo list postgresql
sudo yum list postgresql*

echo install postgres10 and server
sudo yum install postgresql10 postgresql10-server

echo postgres initdb
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb 

echo enable postgres
sudo systemctl enable postgresql-10

echo start postgres
sudo systemctl start postgresql-10 

echo check postgres status
sudo systemctl status postgresql-10

echo stop postgres 
sudo systemctl stop postgresql-10

echo edit postgres configuration
echo edit /var/lib/pgsql/10/data/postgresql.conf
echo Set  unix_socket_directories = '/var/run/postgresql, /tmp'
echo Set  max_connections = 1000
echo Set shared_buffers = 2GB
echo Set listen_addresses = '*' (changed to * instad of local host )

echo setup database roles
echo  example For sourcing the sql file form command line:  psql --username=postgres --host= --port=5432 --dbname=postgres -f mosip_role_regprcuser.sql

#ToDo see if this beit can be moved to the script using sed
echo edit file /var/lib/pgsql/10/data/pg_hba.conf
echo Make with below changes
echo local all all md5 
echo host all all 127.0.0.1/32 ident 
echo host all all 0.0.0.0/0 md5 
echo host all all ::1/128 ident 
echo local replication all peer 
echo host replication all 127.0.0.1/32 ident 
echo host replication all ::1/128 ident


echo Open firewall For port 5432
sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent

echo eload firewall settings
sudo firewall-cmd --reload

echo Set passoword For the user postgres as Mosipopen@123 
echo Set password
sudo passwd postgres
