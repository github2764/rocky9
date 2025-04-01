echo "sudo journalctl -u cockpit.service --no-pager"
echo "*********************************************************************"
sudo journalctl -u cockpit.service --no-pager

sudo firewall-cmd --state

sudo firewall-cmd --list-services
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --list-all

#in order to get the list of ports open by firewalld you have to run --list-all and then 
#if it shows ports(if you used add port command) and services if you used --add-service
#you have to then run sudo firewall-cmd --info-service=cockpit to get to see cockpit port
#so effectively 2 commands to get to see all ports 
