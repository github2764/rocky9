#!/bin/bash

echo "===== Explicit Ports (using --add-port) ====="
sudo firewall-cmd --list-ports
echo

echo "===== Ports from Services (using --add-service) ====="
for svc in $(sudo firewall-cmd --list-services); do
  ports=$(sudo firewall-cmd --info-service=$svc | grep '^  ports:' | cut -d':' -f2 | xargs)
  if [ -n "$ports" ]; then
    echo "$svc => $ports"
  fi
done
