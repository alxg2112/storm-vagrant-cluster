# Storm-Vagrant Cluster
Virtual Storm cluster deployed using Vagrant.

## How to run it
1. Install Vagrant if not done yet
2. Install ActiveMQ, run broker and check if available by URL `http://localhost:8161/admin/queues.jsp`
3. Download `apache-storm-1.0.2.zip` archive, remove `conf/defaults.yaml` file, and place archive in project's root folder
4. Get Vagrant box which will be used by prompting `vagrant box add hashicorp/precise32`
5. Create virtualised cluster by prompting `vagrant up`
6. Once VMs are up and running ssh to nimbus machine by prompting `vagrant ssh nimbus`
7. Prompt `storm jar /usr/share/topology/jms-storm-sample-1.0-jar-with-dependencies.jar Topology JmsStorm`
to submit the topology to Storm
8. Access Storm UI by URL `http://192.168.50.4:8080/index.html`
9. Access ActiveMQ broker by URL `http://localhost:8161/admin/queues.jsp`
