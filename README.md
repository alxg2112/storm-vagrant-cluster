# Storm-Vagrant Cluster
Virtual Storm cluster deployed using Vagrant.

## Prerequisites
- Install **Vagrant**
- Install **hostmanager** plugin by prompting `vagrant plugin install vagrant-hostmanager`
- Install **ActiveMQ**, run broker and check if available by URL `http://localhost:8161/admin/queues.jsp`
- Install GNU **wget**

## How to run it
- Create virtualised cluster by prompting `vagrant up`
- Once VMs are up and running ssh to nimbus machine by prompting `vagrant ssh nimbus`
- Prompt `storm jar /usr/share/topology/jms-storm-sample-1.0-jar-with-dependencies.jar Topology JmsStorm`
to submit the topology to Storm
- Access Storm UI by URL `http://192.168.50.4:8080/index.html`
- Access ActiveMQ broker by URL `http://localhost:8161/admin/queues.jsp` to view upstream and downstream queues
