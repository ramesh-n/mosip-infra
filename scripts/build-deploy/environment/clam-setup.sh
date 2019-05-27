#!/bin/bash
echo Installing clamav-server
sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd

echo install epel-release
sudo yum -y install epel-release

echo Set  stuff up
sudo setsebool -P antivirus_can_scan_system 1
sudo setsebool -P clamd_use_jit 1
sudo getsebool -a | grep antivirus

echo update scan.conf
sudo sed -i -e "s/^Example/#Example/" /etc/clamd.d/scan.conf

echo update freshclam.conf
sudo sed -i -e "s/^Example/#Example/" /etc/freshclam.conf

echo run freshclam
sudo freshclam

echo start clamd@scan
sudo systemctl enable clamd@scan

echo enable clamd@scan
sudo systemctl start clamd@scan

echo configure firewall
sudo firewall-cmd --zone=public --add-port=3310/tcp --permanent

echo reload firewall settings
sudo firewall-cmd --reload

echo In Azure enable port 3310 In network settings  For inbound traffic
 
