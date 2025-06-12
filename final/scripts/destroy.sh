#!/bin/bash
set -e

echo "Destroying infrastructure"

cd terraform
terraform destroy -auto-approve
cd ..

echo "done and dusted."