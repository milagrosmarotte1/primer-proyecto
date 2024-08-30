#!/bin/bash

# Actualiza el sistema
sudo apt-get update -y

# Instala Nginx
sudo apt-get install -y nginx

# Crea una página HTML básica
echo '<!doctype html><html><head><title>My Web Server</title></head><body><h1>Hello, World!</h1></body></html>' | sudo tee /var/www/html/index.html

# Inicia y habilita el servicio Nginx
sudo systemctl start nginx
sudo systemctl enable nginx