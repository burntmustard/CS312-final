#!/bin/bash
set -e

echo "Setting up Minecraft Server final project"

# Check prerequisites
command -v terraform >/dev/null 2>&1 || { echo "Terraform not installed. Exiting." >&2; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo "Ansible not installed. Exiting." >&2; exit 1; }
command -v aws >/dev/null 2>&1 || { echo "AWS CLI not installed. Exiting." >&2; exit 1; }

# Create SSH key pair if it doesn't exist
echo "Creating an SSH key pair"
ssh-keygen -t rsa -b 2048 -f ~/.ssh/minecraft-key -N""


# Initialize Terraform
echo "Initializing Terraform"
cd terraform
terraform init
cd ..

echo "Setup complete"