# Terraform-AWS-Ansible

# AWS Infrastructure as Code (IaC) Assignment

This project demonstrates the creation of a Virtual Private Cloud (VPC) with public and private subnets using Terraform. Additionally, it covers launching EC2 instances and utilizing Ansible to install Git on those instances. the terraform script create a VPC, with 2 Subnets [Private-1 and Public-1], Each Subnet should have 1 EC2 instance, Routing Tables, IG, NAT, Security Groups, I have Used S3 Bucket as Terraform backend to store the state file.

## Important Note

This project is done for academic and learning purposes. While you're welcome to explore and use the code provided, I strongly encourage you to understand the concepts behind it. .
Copying and pasting the code without understanding its workings may limit your ability to adapt and troubleshoot in different contexts. Take the time to explore the documentation of Terraform, Ansible, and AWS. Experiment with different configurations, make changes, and observe the effects. Infrastructure as Code (IaC) is a powerful approach, and it's essential to grasp the fundamentals before applying it to real-world scenarios

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- An AWS account
- Terraform and Ansible installed. (Follow the commands below to install Terraform & Ansible. Note that these commands might vary slightly based on your distribution.refer official documentation for better understanding . install ansible in ypur ec2 instance where you have to install Git)

   ```bash
   # Add HashiCorp GPG key
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

   # Add HashiCorp repository
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

   # Update package index
   sudo apt-get update

   # Install Terraform
   sudo apt-get install terraform
   
   # Install Ansible
   sudo apt-get install ansible 

   # Verify installations:
   Terraform version
   ansible --version
   
- SSH key pair for connecting to instances. (Refer AWS Documentation for creating KeyPair & AWS SecretAccessKey and AccesskeyID)
- Configure AWS CLI with user credentials: provide your AWS Secret Access Key and Access Key ID.
  
   ```bash
       aws configure

## Contents

    main.tf: Terraform configuration file for creating AWS resources.
    variables.tf: Variables used in the Terraform configuration.
    install_git.yml: Ansible playbook file to install Git on an EC2 instance.
    inventory: Ansible inventory file containing the target hosts.
    graph:To visualize the infrastructure created using Infrastructure as Code (IAC) with Terraform.it gives understanding of which resoruces are created and how they are connected.

## Instructions

    - Update the variables.tf file with your desired values.
    - Run terraform init to initialize Terraform.
    - Run terraform apply to create the AWS infrastructure.
    - create install_git.yml & inventory file in EC2 instance where ypu want to install GIT , use commands like nano install_git.yml and nano inventory to create and edit these files.
    - Update the IP address (Host)in the install_git.yml playbook & inventory to match your EC2 instance.
    - Run the Ansible playbook using the command:
            ansible-playbook install_git.yml -i inventory -e ansible_python_interpreter=/usr/bin/python3

## Cleaning Up

Remember to stop or terminate your AWS resources after use to avoid unnecessary charges. To remove the resources created by Terraform, you can use the following command:

      terraform destroy

Before proceeding with the project, make sure you have a good understanding of Terraform and Ansible. Both tools play a vital role in Infrastructure as Code (IaC) and can greatly simplify the process of managing and automating cloud infrastructure.

If you have any queries, suggestions, or feedback, please feel free to contact @nusairtech@gmail.com. I appreciate your interest and involvement in learning , Good luck with your IaC journey! 




