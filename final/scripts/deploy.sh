#!/bin/bash
set -e

echo "Deploying Minecraft server infrastructure..."

# Check AWS credentials
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "AWS credentials not set. Please export AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_SESSION_TOKEN"
    exit 1
fi

# Deploy infrastructure with Terraform
echo "Provisioning infrastructure with Terraform..."
cd terraform
terraform plan
terraform apply -auto-approve

# Get outputs
INSTANCE_IP=$(terraform output -raw instance_public_ip)
echo "Instance IP: $INSTANCE_IP"

# Wait for instance to be ready
echo "Waiting for instance to be ready..."
echo "Testing SSH connectivity..."
for i in {1..10}; do
    if ssh -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=no -i ~/.ssh/minecraft-key ec2-user@$INSTANCE_IP exit 2>/dev/null; then
        break
    else
        echo "Attempt $i: SSH not ready yet, waiting 30 seconds..."
        sleep 30
    fi
done

cd ..

# Configure server with Ansible
echo "Configuring Minecraft server with Ansible"
export ANSIBLE_HOST_KEY_CHECKING=False
cd ansible
ansible-playbook -i inventory/aws_ec2.yml playbooks/minecraft-server.yml

echo "Deployed"
echo "Minecraft server is at: $INSTANCE_IP:25565"