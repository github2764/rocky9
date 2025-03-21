sudo dnf update -y
sudo dnf install -y firewalld

sudo systemctl enable --now cockpit.socket
sudo passwd rocky
