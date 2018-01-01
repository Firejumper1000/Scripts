### SERVER SCRIPT | NGINX RUNNING MULTI-WORDPRESS SERVER ###
#NGINX SERVER SETUP
!/usr/bin/env bash
#chmod +x install.sh
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3` 
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`
echo "${red} Running: ${white}apt-get update ${reset}"
sudo apt-get update
echo "${red} Running: ${white}apt-get install -y nginx ${reset}"
sudo apt-get install -y nginx
sudo /etc/init.d/nginx start
#PHP Install
echo "${red} Running: ${white}apt-get install -y php7.0 ${reset}"
sudo apt-get install -y php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip

phpversion=`php -v | cut -f2`
version=`lsb_release --release | cut -f2`
codename=`lsb_release --codename | cut -f2`

echo "${red} phpversion: ${white}$phpversion ${reset}"
echo "${red} Ubuntu Version: ${white}$version ${reset}"
echo "${red} Ubuntu CodeName: ${white}$codename ${reset}"

#NGINX File setup
echo "${red} Running: ${white} wget http://wordpress.org/latest.tar.gz ${reset}"
sudo wget http://wordpress.org/latest.tar.gz

# note: -p tells mkdir to create all parent directories
echo "${red} Running: ${white}mkdir -p /var/www/site1.com/html ${reset}"
sudo mkdir -p /var/www/site1.com/html
tar -xf latest.tar.gz
# use -r for recursive copy
echo "${red} Running: ${white}cp -r wordpress/* /var/www/site1.com/html ${reset}"
sudo cp -r wordpress/* /var/www/site1.com/html
echo "${red} Running: ${white}chown www-data:www-data /var/www/site1.com/ -R ${reset}"
sudo chown www-data:www-data /var/www/site1.com/ -R

# MARIABD SETUP 
sudo apt-get install software-properties-common
  sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
  sudo add-apt-repository "deb [arch=amd64,i386,ppc64el] http://ftp.ddg.lth.se/mariadb/repo/10.1/ubuntu $(lsb_release -cs) main"
  sudo apt-get update
  sudo apt-get install mariadb-server -y

### PART LEFT TO AUTOMATE ###
# DB Setup
# mysql -u root -p
# CREATE DATABASE site1_db;
# CREATE USER 'site_1_db_user'@'localhost' IDENTIFIED BY 'yourpassword';
# GRANT ALL PRIVILEGES ON site_1_db.* TO 'site_1_db_user'@'localhost';
# quit

# #Testing Local Host
# su
# echo 'Hello world!' >> /var/www/html/index.html
# logout
# curl localhost


# #Testing Grayscale Bootstrap base site
# cd /var/www/html/
# sudo git clone https://github.com/BlackrockDigital/startbootstrap-grayscale.git
# startbootstrap-grayscale
# sudo cp -a /var/www/html/startbootstrap-grayscale/. ./
# sudo rm -rf startbootstrap-grayscale


# #Modifying NGINX default settings
# sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
# sudo rm /etc/nginx/sites-available/default
# sudo nano /etc/nginx/sites-available/default

# server {
#         listen 80;

# #       root /var/www/html;
#         root /var/www/site1.com/html;
#         index index.php index.html;

#         server_name site1.com *.site1.com;

#         location ~ \.php$ {
#           #NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
#           include fastcgi_params;
#           fastcgi_intercept_errors on;
#           fastcgi_pass unix:/run/php/php7.0-fpm.sock;
#           fastcgi_param SCRIPT_FILENAME $document_root/$fastcgi_script_name;
#         }
# }


# sudo rm /etc/nginx/sites-enabled/default

# sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/site1.com

# sudo ln -s /etc/nginx/sites-available/site1.com /etc/nginx/sites-enabled/
# sudo ln -s /etc/nginx/sites-available/site2.com /etc/nginx/sites-enabled/

# sudo /etc/init.d/nginx restart
