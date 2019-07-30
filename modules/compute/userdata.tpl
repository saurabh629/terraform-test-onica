#!/bin/bash

# user-data script for installing and configuring nginx
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo rm -rf /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default
sudo bash -c 'cat > /etc/nginx/sites-available/default' << EOF
server {
	listen 80 default_server;
	server_name www.test.com;
	location / {
		add_header Content-Type text/plain;
		return 200 "\nhello test\n";
	}
}
server {
	listen 80;
	server_name ww2.test.com;
	location / {
		add_header Content-Type text/plain;
		return 200 "\nhello test2\n";
		}
}
EOF
sudo systemctl restart nginx
