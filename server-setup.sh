sudo dnf update -y
sudo dnf install -y firewalld
sudo systemctl enable --now firewalld

#--now will actually start the socket right away. no need to start cockpit.service if you want on demand socket 
#activated cockpit-service for efficiency
sudo systemctl enable --now cockpit.socket
#in order to login into cockpit via browser we need login and pass
sudo passwd rocky

#enable selinux if disabled
