variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "honeypot-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "honeypot-subnet"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "honeypot-vm"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "crhoneymaster"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "admin_ip" {
  description = "Your public IP for SSH access"
  type        = string
}
variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    owner       = "Makol Johnchuol"
    company     = "Crossrealms International"
    environment = "production"
  }
}
