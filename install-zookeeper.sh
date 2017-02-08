apt-get update

# Create Storm user
groupadd storm
useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm

# Install JDK
sudo apt-get install openjdk-7-jdk

# Install zookeeper
tar -oxzvf /vagrant/zookeeper-3.4.9.tar.gz -C /usr/share
chown -R storm:storm /usr/share/zookeeper-3.4.9

# Add zookeeper config file
cd /usr/share/zookeeper-3.4.9/conf
truncate -s 0 zoo.cfg
printf "tickTime=2000\ninitLimit=10\nsyncLimit=5\ndataDir=/var/zookeeper\nclientPort=2181" >> zoo.cfg

# Start zookeeper
sudo /usr/share/zookeeper-3.4.9/bin/zkServer.sh start

#cd /usr/share/zookeeper-3.4.9/conf
#cd /usr/share/zookeeper-3.4.9/bin
#sudo bash -c 'truncate -s 0 zoo.cfg'
#sudo bash -c 'printf "tickTime=2000\ninitLimit=10\nsyncLimit=5\ndataDir=/var/zookeeper\nclientPort=2181" >> zoo.cfg'
#sudo /usr/share/zookeeper-3.4.9/bin/zkServer.sh restart