# Terraform-AWS-Ansible

# AWS Infrastructure as Code (IaC) Assignment

This project demonstrates the creation of a Virtual Private Cloud (VPC) with public and private subnets using Terraform. Additionally, it covers launching EC2 instances and utilizing Ansible to install Git on those instances. the terraform script create a VPC, with 2 Subnets [Private-1 and Public-1], Each Subnet should have 1 EC2 instance, Routing Tables, IG, NAT, Security Groups, Use S3 Bucket as Terraform backend.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- An AWS account
- Terraform installed. Follow the commands below to install Terraform. Note that these commands might vary slightly based on your distribution.refer official documentation for better understanding

   ```bash
   # Add HashiCorp GPG key
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

   # Add HashiCorp repository
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

   # Update package index
   sudo apt-get update

   # Install Terraform
   sudo apt-get install terraform

   #Verify installations:
   Terraform version
- configure Ansible installed. Use the following commands:

   ```bash
       # Update package index
       sudo apt-get update

       # Install Ansible
       sudo apt-get install ansible

       #Verify installations:
       ansible --version
-An SSH key pair for connecting to instances.
-Configure AWS CLI with user credentials:
```bash
         aws configure





