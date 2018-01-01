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
sudo chown www-data:www-data /var/www/iwikeit.com/ -R

# MARIABD SETUP
sudo apt-get install software-properties-common
  sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
  sudo add-apt-repository "deb [arch=amd64,i386,ppc64el] http://ftp.ddg.lth.se/mariadb/repo/10.1/ubuntu $(lsb_release -cs) main"
  sudo apt-get update
  sudo apt-get install mariadb-server -y
