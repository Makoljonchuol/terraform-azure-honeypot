#------------------------------------------------------------------------------
# Resource Group Variables
#------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  # Specify the name for the resource group where all resources will be deployed.
}

#------------------------------------------------------------------------------
# Location Variables
#------------------------------------------------------------------------------

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westus"
  # Set the Azure region for resource deployment. Default is 'westusus'.
}

#------------------------------------------------------------------------------
# Virtual Network (VNet) Variables
#------------------------------------------------------------------------------

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "honeypot-vnet"
  # Name of the Azure Virtual Network to be created.
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
  # CIDR block for the VNet address space.
}

#------------------------------------------------------------------------------
# Subnet Variables
#------------------------------------------------------------------------------

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "honeypot-subnet"
  # Name of the subnet within the VNet.
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
  default     = "10.0.1.0/24"
  # CIDR block for the subnet address prefix.
}

#------------------------------------------------------------------------------
# Virtual Machine (VM) Variables
#------------------------------------------------------------------------------

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "honeypot-vm"
  # Name of the Azure Virtual Machine.
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B2s"
  # Specifies the size of the VM. Adjust based on workload requirements.
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "crhoneymaster"
  # Username for administrative access to the VM.
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  # Local path to the SSH public key for VM authentication.
}

#------------------------------------------------------------------------------
# Security Variables
#------------------------------------------------------------------------------

variable "admin_ip" {
  description = "Your public IP for SSH access"
  type        = string
  # Restricts SSH access to the VM from this public IP address.
}

#------------------------------------------------------------------------------
# Subscription Variables
#------------------------------------------------------------------------------

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  # The Subscription ID that Terraform will deploy resources into.
}

#------------------------------------------------------------------------------
# Tagging Variables
#------------------------------------------------------------------------------

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    owner       = "Makol Johnchuol"
    company     = "Crossrealms International"
    environment = "production"
  }
  # Key-value pairs for resource tagging to support management and cost tracking.
}
