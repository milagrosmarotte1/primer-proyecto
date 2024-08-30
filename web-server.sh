#!/bin/bash

# UPDATE PACKAGE MANAGER
apt update --fix-missing

# INSTALL, START and ENABLE NGINX
apt install -y nginx
systemctl start nginx
systemctl enable nginx

# CHANGE FILE PERMISSION TO PERMIT MODIFICATION OF DEFAULT WEB FILE
chmod 0777 /var/www/html/index.nginx-debian.html

# MODIFY DEFAULT WEB DOCUMENT
echo "<html><h1>Hello from your web server!</h1></html>" > /var/www/html/index.nginx-debian.html

# RESTART NGINX
systemctl start nginx