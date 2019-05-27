#!/bin/bash
echo Install open jdk
sudo yum install java-1.8.0-openjdk-devel

echo run update-alternatives
update-alternatives --display java

echo Set java path in ~/.bashrc
# ToDo add the code to add java path to bashrc

echo Run ifconfig
ifconfig

echo Note: Add the host in /etc/hosts with the DNS name. Example below
# ToDo add the host in /etc/hosts with DNS name

echo 10.0.22.11 node-master.example.com
echo Generate ssh key and using ssh-keygen -t rsa
echo And copy the public to same server and try to login in without using password.

echo run ssh-copy-id
ssh-copy-id -i $HOME/.ssh/id_rsa.pub mosip-open@mosip-staging-test.eastus.cloudapp.com

echo check ssh
ssh mosip-open@mosip-staging-test.eastus.cloudapp.com

echo Download hdfs 
cd 
echo Get hdfs
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.8.1/hadoop-2.8.1.tar.gz

echo extract tarball
tar -xzf hadoop-2.8.1.tar.gz

echo move to hadoop
mv hadoop-2.8.1 hadoop

echo Set hdfs path in ~/.bashrc 
# ToDo script to add this

echo Export Variables HADOOP_HOMEm HADOOP_MAPRED_HOME, HADOOP_COMMON_HOME, HADOOP_HDFS_HOME, YARN_HOME, PATH
export HADOOP_HOME=$HOME/hadoop export HADOOP_CONF_DIR=$HOME/hadoop/etc/hadoop
export HADOOP_MAPRED_HOME=$HOME/hadoop
export HADOOP_COMMON_HOME=$HOME/hadoop
export HADOOP_HDFS_HOME=$HOME/hadoop
export YARN_HOME=$HOME/hadoop
export PATH=$PATH:$HOME/hadoop/bin

echo Update ~/hadoop/etc/hadoop/core-site.xml :

echo Change the owner of the hadoop file
chown mosip-open:mosip-open ~/hadoop/

echo enable firewall Ports 51000, 51090, 51091, 51010, 51075, 51020, 51470, 51100, 51105 For tcp

sudo firewall-cmd --zone=public --add-port=51000/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51090/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51091/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51010/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51075/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51020/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51470/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51100/tcp --permanent
sudo firewall-cmd --zone=public --add-port=51105/tcp --permanent

echo reload firewall settings
sudo firewall-cmd --reload
 

