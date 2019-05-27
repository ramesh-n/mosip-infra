#!/bin/bash
echo Get apacheds-2.0.0 bin file
wget http://mirrors.estointernet.in/apache//directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-64bit.bin

cd 

echo extract apacheds
bash apacheds-2.0.0.AM25-64bit.bin

echo go to conf folder
cd ~/demo/installations/apacheds-2.0.0.AM25/conf

echo run update-alternatives
update-alternatives --display java

echo edit wrapper.conf and Set java path
#nano wrapper.conf

echo Change the java path 
echo wrapper.java.library.path.1=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64/jre/bin
#ToDo adding this change to wrapper.conf
cd ..

echo start apacheds
./apacheds-2.0.0.AM25-mosip start

echo show apacheds status
./apacheds-2.0.0.AM25-mosip status

