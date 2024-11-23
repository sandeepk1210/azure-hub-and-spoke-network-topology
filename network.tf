# Virtual Network - HUB
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.hub_address_space

  tags = local.common_tags
}

# Default Subnet - HUB
resource "azurerm_subnet" "hub_vnet_subnet" {
  for_each             = var.hub_subnet
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [each.value]
}


# Virtual Network - SpokeA
resource "azurerm_virtual_network" "spokeA_vnet" {
  name                = var.spokeA_vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.spokeA_address_space

  tags = local.common_tags
}

#  Subnet - SpokeA
resource "azurerm_subnet" "spokeA_subnet" {
  for_each             = var.spokeA_subnet
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spokeA_vnet.name
  address_prefixes     = [each.value]
}

# Virtual Network - SpokeB
resource "azurerm_virtual_network" "spokeB_vnet" {
  name                = var.spokeB_vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.spokeB_address_space

  tags = local.common_tags
}

#  Subnet- SpokeB
resource "azurerm_subnet" "spokeB_subnet" {
  for_each             = var.spokeB_subnet
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spokeB_vnet.name
  address_prefixes     = [each.value]
}


# Define the peering from vnet-spokeA to hub-vnet
# It enables to seamlessly connect two or more Virtual Networks in Azure.
resource "azurerm_virtual_network_peering" "spokeA_to_hub" {
  name                      = "spokeA-to-hub"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.spokeA_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# Define the peering from hub-vnet to vnet-spokeA
resource "azurerm_virtual_network_peering" "hub_to_spokeA" {
  name                      = "hub-to-spokeA"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spokeA_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}


# Define the peering from vnet-spokeB to hub-vnet
# It enables to seamlessly connect two or more Virtual Networks in Azure.
resource "azurerm_virtual_network_peering" "spokeB_to_hub" {
  name                      = "spokeB-to-hub"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.spokeB_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# Define the peering from hub-vnet to vnet-spokeB
resource "azurerm_virtual_network_peering" "hub_to_spokeB" {
  name                      = "hub-to-spokeB"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spokeB_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}
