# !/bin/bash

sudo install httpd -y
sudo systemctl start httpd 
sudo systemctl enable httpd
echo "Welcome to NAGARJUNA GROUP OF HOMES -TERRAFORM " > /var/www/html/index.htmL