!/bin/bash

#chmod +x docker_install.sh
red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
reset=`tput sgr0`
echo "${cyan}Docker ${green}Shell install Script ${reset}"
# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true;
# Continued from above example
echo -e "${red} Running: ${green}apt-get update ${reset}"
sudo apt-get update -y

# Install packages to allow apt to use a repository over HTTPS:
echo -e "${red} Running: ${green}apt-get transport, certs, & Software ${reset}"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y;

# Add Docker’s official GPG key:
echo "${cyan}Adding Docker ${green} GPG Key ${reset}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;

# Verify that you now have the key with the fingerprint
echo "${cyan}Adding Docker ${green} Fingerprint ${reset}"
sudo apt-key fingerprint 0EBFCD88;

# Use the following command to set up the stable repository
echo "${cyan}Adding Docker ${green} Repo ${reset}"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y;

# Update
echo -e "${red} Running ${green} 2nd:apt-get update ${reset}"
sudo apt-get update -y;

# Install the latest version of Docker CE
echo "${red}Running: ${cyan} Docker-CE ${green} Install ${reset}"
sudo apt-get install docker-ce y;
sudo apt install docker.io y;

# Install docker-compose
echo "${red}Running: ${cyan} Docker-Compose ${green} Install ${reset}"
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# End of Script
echo "${red}End of Script ${reset}"
