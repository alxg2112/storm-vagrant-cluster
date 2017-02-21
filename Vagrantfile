# -*- mode: ruby -*-
# vi: set ft=ruby :

# Constants
VAGRANTFILE_API_VERSION = "2"
STORM_VERSION = "apache-storm-1.0.2"
STORM_ARCHIVE = "#{STORM_VERSION}.zip"
ZOOKEEPER_VERSION = "zookeeper-3.4.9"
ZOOKEEPER_ARCHIVE = "#{ZOOKEEPER_VERSION}.tar.gz"
TOPOLOGY_ARCHIVE = "jms-storm-sample-1.0-jar-with-dependencies"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true
  
  # Download Storm archive
  if(!File.exist?(STORM_ARCHIVE))
    `wget -N http://apache.volia.net/storm/apache-storm-1.0.2/apache-storm-1.0.2.zip`
  end

  # Download Zookeeper archive
  if(!File.exist?(ZOOKEEPER_ARCHIVE))
    `wget -N http://apache.ip-connect.vn.ua/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz`
  end

  # Define zookeeper
  config.vm.define "zookeeper" do |zookeeper|
    zookeeper.vm.box = "hashicorp/precise32"
    zookeeper.vm.network "private_network", ip: "192.168.50.3"
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.vm.provision "shell", path: "install-zookeeper.sh"
  end

  # Define nimbus
  config.vm.define "nimbus" do |nimbus|
    nimbus.vm.box = "hashicorp/precise32"
    nimbus.vm.network "private_network", ip: "192.168.50.4"
    nimbus.vm.hostname = "nimbus"

    nimbus.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, TOPOLOGY_ARCHIVE]

    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "nimbus"

    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "ui"

    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "drpc"

    nimbus.vm.provision "shell", path: "start-supervisord.sh"
  end

  # Define worker VM 1
  config.vm.define "supervisor1" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.5"
    supervisor.vm.hostname = "supervisor1"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, TOPOLOGY_ARCHIVE]

    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"

    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"

    supervisor.vm.provision "shell", path: "start-supervisord.sh"

  end

  # Define worker VM 2
  config.vm.define "supervisor2" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.6"
    supervisor.vm.hostname = "supervisor2"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, TOPOLOGY_ARCHIVE]

    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"

    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"

    supervisor.vm.provision "shell", path: "start-supervisord.sh"

  end

  # Define worker VM 3
  config.vm.define "supervisor3" do |supervisor|
    supervisor.vm.box = "hashicorp/precise32"
    supervisor.vm.network "private_network", ip: "192.168.50.7"
    supervisor.vm.hostname = "supervisor3"

    supervisor.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, TOPOLOGY_ARCHIVE]

    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"

    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"

    supervisor.vm.provision "shell", path: "start-supervisord.sh"

  end
end
