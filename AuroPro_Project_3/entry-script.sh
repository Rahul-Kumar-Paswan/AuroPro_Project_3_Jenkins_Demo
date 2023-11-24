#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker 
sudo usermod -aG docker ec2-user
sudo chmod 666 /var/run/docker.sock
sudo service docker restart

# install mysql 
sudo yum update -y
sudo yum install mariadb-server
sudo systemctl start mariadb

# install docker-compose 
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose