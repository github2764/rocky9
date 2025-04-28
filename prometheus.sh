#!/bin/bash

# Exit on any error
set -e

# Variables
PROM_VERSION="2.52.0"  # Update this if you want a newer version
USER="prometheus"
GROUP="prometheus"
INSTALL_DIR="/opt/prometheus"
DATA_DIR="/var/lib/prometheus"
SERVICE_FILE="/etc/systemd/system/prometheus.service"

# Create Prometheus user and directories
echo "Creating Prometheus user and directories..."
sudo useradd --no-create-home --shell /bin/false $USER || true
sudo mkdir -p $INSTALL_DIR $DATA_DIR
sudo chown $USER:$GROUP $DATA_DIR
sudo chown $USER:$GROUP $INSTALL_DIR

# Download Prometheus
echo "Downloading Prometheus $PROM_VERSION..."
cd /tmp
curl -LO "https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz"

# Extract and move binaries
echo "Installing Prometheus binaries..."
tar xvf "prometheus-${PROM_VERSION}.linux-amd64.tar.gz"
cd "prometheus-${PROM_VERSION}.linux-amd64"

sudo cp prometheus promtool /usr/local/bin/
sudo chown $USER:$GROUP /usr/local/bin/prometheus /usr/local/bin/promtool

# Move config and consoles
sudo cp -r consoles console_libraries prometheus.yml $INSTALL_DIR/
sudo chown -R $USER:$GROUP $INSTALL_DIR

# Create systemd service
echo "Creating systemd service..."
cat <<EOF | sudo tee $SERVICE_FILE
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=$USER
Group=$GROUP
Type=simple
ExecStart=/usr/local/bin/prometheus \\
    --config.file=$INSTALL_DIR/prometheus.yml \\
    --storage.tsdb.path=$DATA_DIR \\
    --web.console.templates=$INSTALL_DIR/consoles \\
    --web.console.libraries=$INSTALL_DIR/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Prometheus
echo "Enabling and starting Prometheus..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

echo "Prometheus installation completed successfully!"
echo "Access it at http://<server-ip>:9090"
