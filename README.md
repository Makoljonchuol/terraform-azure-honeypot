# Terraform Azure Honeypot Deployment

This project uses Terraform to provision a virtual machine (VM) on Microsoft Azure that runs the T-Pot honeypot, configured with the ELK (Elasticsearch, Logstash, Kibana) Full Edition. The infrastructure is automated and designed for secure, repeatable deployments that follow production-grade best practices.

## Author

Makol Johnchuol Deng  
Cybersecurity Engineering Intern  
Crossrealms International

## Overview

This infrastructure as code (IaC) project performs the following:

- Provisions a secure Linux VM on Azure
- Installs the T-Pot honeypot stack with ELK Full Edition
- Restricts access to SSH and the web UI using IP whitelisting
- Exposes honeypot services over standard and known ports
- Tags Azure resources for easy management and traceability

## Project Structure

This repository is organized as follows:

.
├── install_tpot.sh # Script to install the T-Pot honeypot on the VM
├── main.tf # Main Terraform configuration and resource definitions
├── outputs.tf # Outputs useful deployment information, such as IP address
├── provider.tf # Azure provider configuration for Terraform
├── terraform.tfvars # User-specific variable values (unique to each deployment)
├── variables.tf # All variables used in the Terraform configuration
└── scripts/ # Optional folder for additional provisioning scripts

text

## File Descriptions

### main.tf

Defines the core Azure infrastructure:

- Resource Group
- Virtual Network
- Subnet
- Network Security Group (NSG) with allowed ports
- Public IP and Network Interface
- Linux Virtual Machine

### provider.tf

Configures the Azure provider. For local development, it uses the Azure CLI (`az login`). For automation environments, the provider can be extended to use a service principal.

provider "azurerm" {
features {}
}



### variables.tf

Declares all input variables including names, locations, IP ranges, VM sizing, tagging, and access control.

### terraform.tfvars

Contains user-supplied values for the variables. This is where you customize your deployment.

Example:

resource_group_name = "honeypot-prod-rg"
location = "eastus"
admin_ip = "YOUR.PUBLIC.IP/32"

tags = {
environment = "production"
owner = "Makol Chuol Deng"
company = "Crossrealms International"
}

### outputs.tf

After deployment, this file prints the public IP address of the deployed honeypot VM:

output "public_ip_address" {
description = "The public IP address of the honeypot VM"
value = azurerm_public_ip.main.ip_address
}


### install_tpot.sh

This script is placed on the VM during provisioning and automatically runs at startup. It performs a system upgrade and downloads and runs the official T-Pot installation script.

Contents:

#!/bin/bash
sudo apt update && sudo apt upgrade -y
wget https://github.com/telekom-security/tpotce/raw/master/installer/install.sh
sudo bash install.sh



## Prerequisites

- Azure subscription (Free or Paid)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- SSH key pair (public key used for secure login)

## Setup Instructions

### Step 1: Login to Azure

Authenticate using the Azure CLI:

az login

If you have multiple subscriptions, set the one you'd like to use:

az account set --subscription "YOUR-SUBSCRIPTION-NAME"


### Step 2: Configure the Terraform Variables

Edit the `terraform.tfvars` file and fill in the required values:

- Use a trusted public IP to limit SSH and web UI access.
- Get your current public IP with: `curl https://api.ipify.org`

### Step 3: Initialize Terraform

Run the following from the project root directory:

terraform init


### Step 4: Preview the Changes

Review the resources to be created:

terraform plan -var-file="terraform.tfvars"


### Step 5: Deploy the Infrastructure

Apply the configuration and deploy the honeypot:

terraform apply -var-file="terraform.tfvars"


Terraform will ask for confirmation before provisioning starts.

## Accessing the Honeypot

### SSH Access

After deployment completes, use the outputted public IP to connect:

ssh <admin_username>@<public_ip>


Use the username defined in your `terraform.tfvars` (e.g., `crhoneymaster`).

### Web UI (Kibana)

Access the T-Pot web interface in a browser:

https://<public_ip>:64297


You will be prompted to create a web username and password during the T-Pot installation process.

## Security Configuration

- SSH access (`port 22`) restricted to administrator IP
- T-Pot Web UI (`port 64297`) also restricted to administrator IP
- Common honeypot ports for HTTP (`80`) and HTTPS (`443`) are publicly exposed
- Additional honeypot ports can be added in the `main.tf` file

## Post-Deployment Notes

- T-Pot installation requires user interaction in the terminal. You must SSH into the VM and follow the prompts during installation.
- The installation process may take 15–30 minutes depending on VM size and network speed.
- After install completes, T-Pot services will start automatically and logs can be viewed on the dashboards.

## Future Enhancements

- Switch to a service principal for CI/CD and production deployments
- Use a remote Terraform backend (e.g., Azure Blob Storage) for state management
- Modularize the project for multi-region deployment
- Automate full T-Pot install (non-interactive) using pre-seeded environment variables

## License

This project is for internal use, education, security research, and training purposes only.
## Azure Authentication and Configuration

### Prerequisites

Before deploying with Terraform, ensure you have:

- Azure CLI installed
- Valid Azure account with permissions
- Active Azure subscription

### Authentication Setup

#### Azure CLI Authentication

This project uses Azure CLI for authentication, allowing Terraform to authorize API requests securely without storing credentials in files.

**Installation and Setup:**

1. Install Azure CLI:
    ```bash
    brew install azure-cli
    ```
2. Verify installation:
    ```bash
    az --version
    ```
3. Login to Azure:
    ```bash
    az login
    ```
4. Select subscription (if needed):
    ```bash
    az account set --subscription "SUBSCRIPTION_ID_OR_NAME"
    ```
5. Confirm active subscription:
    ```bash
    az account show
    ```

**Terraform Provider Configuration:**
```hcl
provider "azurerm" {
  features {}
}
```
Terraform uses the credentials and subscription from your Azure CLI session.

### Required Configuration Values

1. **Azure Subscription ID:**
    ```bash
    az account show --query id -o tsv
    ```
2. **Public IP Address:**
    ```bash
    curl https://api.ipify.org
    ```
3. **Terraform Variables:**
    Update `terraform.tfvars`:
    ```hcl
    subscription_id = "your-subscription-id-here"
    admin_ip        = "your-public-ip-here/32"
    ```
    Example:
    ```hcl
    subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    admin_ip        = "198.51.100.13/32"
    ```

### Security Benefits

- No embedded secrets in code or configs
- Simplified authentication for developers
- Permission-scoped access
- IP-restricted SSH and management access

### Best Practices

- Use Azure CLI authentication for local development
- Switch to Service Principal for CI/CD and production
- Always use `/32` for IP restriction
- Team members should use correct subscription and trusted IPs

### Troubleshooting

- Check current account: `az account show`
- Verify permissions in subscription
- Ensure IP address matches configuration
- Re-authenticate if needed: `az login`
