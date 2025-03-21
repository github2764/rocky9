sudo dnf update -y
sudo dnf install firewalld
sudo systemctl enable --now cockpit.socket
