resource_group_name = "Regroup_6d9qWpIbOPGi0_SWq"

#Network as Hub
hub_vnet_name     = "vnet-HUB"
hub_address_space = ["10.0.0.0/16"]
hub_subnet = {
  "default"       = "10.0.0.0/24",
  "GatewaySubnet" = "10.0.1.0/24"
}
vm_count       = 2 # Identity how many VMs to be created
admin_username = "adminuser"
vm_size        = "Standard_B2s"

#Network as Spoke A
spokeA_vnet_name     = "vnet-spokeA"
spokeA_address_space = ["10.1.0.0/16"]
spokeA_subnet = {
  "default" = "10.1.0.0/24"
}

#Network as Spoke B
spokeB_vnet_name     = "vnet-spokeB"
spokeB_address_space = ["10.2.0.0/16"]
spokeB_subnet = {
  "default" = "10.2.0.0/24"
}

# Virtual Network Gateway
vpn_gateway_name = "vnet-gateway"
gateway_sku      = "VpnGw1" # Options: Basic, VpnGw1, VpnGw2, etc.
