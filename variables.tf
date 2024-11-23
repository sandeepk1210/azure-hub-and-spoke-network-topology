variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

# Network
variable "hub_vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "hub_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "hub_subnet" {
  type        = map(string)
  description = "Hub subnets consists of subnet name and subnet range"
}

variable "spokeA_vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "spokeA_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "spokeA_subnet" {
  type        = map(string)
  description = "spokeB subnets consists of subnet name and subnet range"
}

variable "spokeB_vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "spokeB_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "spokeB_subnet" {
  type        = map(string)
  description = "spokeB subnets consists of subnet name and subnet range"
}

# Virtual Network Gateway
variable "vpn_gateway_name" {
  type        = string
  description = "Name of the VPN gateway"
}

variable "gateway_sku" {
  type        = string
  description = "Gateway SKU"
}

# VM
variable "vm_count" {
  type        = number
  description = "The number of virtual machines to create"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machines"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the virtual machines"
}
