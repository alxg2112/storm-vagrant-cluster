# Update system and install JDK 7
apt-get update
apt-get install -y unzip supervisor openjdk-7-jdk

/etc/init.d/supervisor stop

# Create Storm user
groupadd storm
useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm

# Disable firewall
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F

# Update environment variables
cd /etc
truncate -s 0 environment
printf "JAVA_HOME=\"/usr/lib/jvm/java-7-openjdk-i386\"\n" >> environment
printf "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$JAVA_HOME/bin\"" >> environment
source /etc/environment

# Unzip Storm
unzip -o /vagrant/$1.zip -d /usr/share/
chown -R storm:storm /usr/share/$1
ln -s /usr/share/$1 /usr/share/storm
ln -s /usr/share/storm/bin/storm /usr/bin/storm

# Unzip topology jar
unzip -o /vagrant/$2.zip -d /usr/share/topology
chown -R storm:storm /usr/share/topology
ln -s /usr/share/topology/$2.jar /usr/bin/topology

mkdir /etc/storm
chown storm:storm /etc/storm

# Replace default config files
rm /usr/share/storm/conf/storm.yaml
cp /vagrant/storm.yaml /usr/share/storm/conf/
cp /vagrant/cluster.xml /usr/share/storm/logback/
ln -s /usr/share/storm/conf/storm.yaml /etc/storm/storm.yaml 

# Create log directory
mkdir /var/log/storm
chown storm:storm /var/log/storm

#sed -i 's/${storm.home}\/logs/\/var\/log\/storm/g' /usr/share/storm/logback/cluster.xml
