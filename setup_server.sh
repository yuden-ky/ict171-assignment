#!/bin/bash

# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Install Apache web server and required packages
sudo apt install apache2 ufw openssl -y

# Configure the firewall
sudo ufw allow OpenSSH
sudo ufw allow 'Apache Full'
sudo ufw --force enable

# Generate a self-signed SSL certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/apache-selfsigned.key \
-out /etc/ssl/certs/apache-selfsigned.crt \
-subj "/C=KE/ST=Nairobi/L=Nairobi/O=MyPortfolio/OU=ICT171/CN=[REPLACE_WITH_YOUR_DOMAIN]"

# Configure Apache to use SSL
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo systemctl reload apache2
