# modules/atlantis/templates/startup.sh

#!/bin/bash

apt-get update
apt-get install -y docker.io docker-compose jq

cat > /home/ubuntu/docker-compose.yml <<EOF
version: "3.8"
services:
  atlantis:
    image: ghcr.io/runatlantis/atlantis:latest
    ports:
      - "80:8080"
      - "443:8080"
    environment:
      ATLANTIS_REPO_ALLOWLIST: "${atlantis_repo_allowlist}"
      ATLANTIS_GITHUB_APP_ID: "${github_app_id}"
      ATLANTIS_GITHUB_APP_INSTALLATION_ID: "${github_app_installation_id}"
      ATLANTIS_GITHUB_PRIVATE_KEY: "${github_private_key}"
      ATLANTIS_GH_WEBHOOK_SECRET: "${github_webhook_secret}"
EOF

chown -R ubuntu:ubuntu /home/ubuntu
docker-compose -f /home/ubuntu/docker-compose.yml up -d

# Optional: Set up a basic health check
# This can be expanded upon for more robust checks.
echo "Setting up health check..."
cat > /opt/healthcheck.sh <<EOF
#!/bin/bash
curl -s http://localhost:8080 | grep -q "Atlantis"
if [ \$? -eq 0 ]; then
  exit 0
else
  exit 1
fi
EOF
chmod +x /opt/healthcheck.sh

# Configure systemd service for health checks (optional)
cat > /etc/systemd/system/atlantis-healthcheck.service <<EOF
[Unit]
Description=Atlantis Health Check

[Service]
ExecStart=/opt/healthcheck.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable atlantis-healthcheck.service
systemctl start atlantis-healthcheck.service

echo "Atlantis installation complete.  Access Atlantis at http://<public_ip> or https://<public_ip>."