# adding repository and installing nginx		
sudo apt update
sudo apt install nginx -y
sudo ln -sf /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions/mount.vboxsf /sbin/mount.vboxsf

cat <<EOT>> vproapp
upstream vproapp {

 server app01:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT

mv vproapp /etc/nginx/sites-available/vproapp
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

#starting nginx service and firewall
systemctl start nginx
systemctl enable nginx
systemctl restart nginx
