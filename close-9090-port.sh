#You can remove the cockpit service from the firewall like this:
sudo firewall-cmd --zone=public --remove-service=cockpit --permanent
firewall-cmd --reload



#If you’re not using Cockpit (a web-based admin tool), you can also disable it entirely as below
#systemctl disable --now cockpit.socket
