#!/bin/bash
set -e

echo "Validating Minecraft server deployment..."

cd terraform
INSTANCE_IP=$(terraform output -raw instance_public_ip)
cd ..

if [ -z "$INSTANCE_IP" ]; then
    echo "Could not get instance IP. Is the infrastructure deployed?"
    exit 1
fi

echo "Testing connection to Minecraft server at $INSTANCE_IP:25565"

# Test with nmap as required
nmap -sV -Pn -p T:25565 $INSTANCE_IP

echo "Validation complete!"