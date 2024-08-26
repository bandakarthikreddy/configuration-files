sudo -i
sudo apt update && sudo apt upgrade -y
sudo apt update

sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz -P /opt

cd /opt

sudo tar -zxvf apache-tomcat-10.1.26.tar.gz
sudo mv apache-tomcat-10.1.26 tomcat
sudo rm -rf apache-tomcat-10.1.26.tar.gz

sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'

git clone https://github.com/bandakarthikreddy/configuration-files.git

sudo mv tomcat.service /etc/systemd/system/tomcat.service
sudo cp -r content.xml /opt/tomcat/webapps/manager/META-INF/
sudo cp -r content.xml /opt/tomcat/webapps/host-manager/META-INF/
sudo cp -r tomcat-users.xml /opt/tomcat/conf/

java --version
JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64/"
echo $JAVA_HOME
sudo systemctl daemon-reload
systemctl enable tomcat
systemctl restart tomcat
systemctl status tomcat
