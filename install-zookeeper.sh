apt-get update

# Create Storm user
groupadd storm
useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm

# Install JDK
apt-get install -y unzip supervisor openjdk-7-jdk

# Install zookeeper
tar -oxzvf /vagrant/zookeeper-3.4.9.tar.gz -C /usr/share
chown -R storm:storm /usr/share/zookeeper-3.4.9

# Add zookeeper config file
cd /usr/share/zookeeper-3.4.9/conf
truncate -s 0 zoo.cfg
printf "tickTime=2000\n" >> zoo.cfg
printf "initLimit=10\n" >> zoo.cfg
printf "syncLimit=5\n" >> zoo.cfg
printf "dataDir=/var/zookeeper\n" >> zoo.cfg
printf "clientPort=2181" >> zoo.cfg

# Disable firewall
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F

# Update environment variables
cd /etc
truncate -s 0 environment
printf "JAVA_HOME=\"/usr/lib/jvm/java-7-openjdk-i386\"\n" >> environment
printf "ZOOKEEPER_HOME=\"/usr/share/zookeeper-3.4.9\"\n" >> environment
printf "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$JAVA_HOME/bin:$ZOOKEEPER_HOME/bin\"" >> environment
source /etc/environment

# Start zookeeper
sudo /usr/share/zookeeper-3.4.9/bin/zkServer.sh start