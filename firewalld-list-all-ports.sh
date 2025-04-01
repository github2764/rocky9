echo "Explicit ports:"
sudo firewall-cmd --list-ports

echo -e "\nPorts from services:"
for svc in $(sudo firewall-cmd --list-services); do
  ports=$(sudo firewall-cmd --info-service=$svc | grep '^  ports:' | cut -d':' -f2)
  [ -n "$ports" ] && echo "$svc =>$ports"
done
