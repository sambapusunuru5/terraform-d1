#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user
sudo echo "Welcome to nginx using terraform" >> index.html
sudo docker run -d -p 8080:80 nginx
sudo docker cp index.html $(sudo docker ps -aq):/usr/share/nginx/html/index.html