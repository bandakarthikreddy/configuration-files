#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-17-jre-headless -y

cd /opt || exit 1

sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz
sudo tar -zxvf apache-tomcat-9.0.93.tar.gz
sudo mv apache-tomcat-9.0.93 tomcat

sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
sudo chown -R tomcat: /opt/tomcat
sudo chmod +x /opt/tomcat/bin/*.sh

# Adding the git clone step here, assuming it's needed after the Tomcat setup
sudo git clone https://github.com/bandakarthikreddy/configuration-files.git

sudo mv /opt/configuration-files/tomcat-users.xml /opt/tomcat/conf/
sudo cp -r /opt/configuration-files/context.xml /opt/tomcat/webapps/manager/META-INF/
sudo cp -r /opt/configuration-files/context.xml /opt/tomcat/webapps/host-manager/META-INF/
sudo cp -r /opt/configuration-files/tomcat.service /etc/systemd/system/


sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl restart tomcat
sudo systemctl status tomcat
