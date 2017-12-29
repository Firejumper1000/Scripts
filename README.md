This is a git repo

Rev. 1

I keep reinstalling Docker for testing purposes on a single AWS node. 
This setup script does the updates for ubuntu and installs Docker-CE & Comppose.

Update: Be sure to run: 

#add sudo access to your user:
sudo usermod -aG docker ${USER} 

#Add to or start swarm
docker swarm init 

Cheers!

