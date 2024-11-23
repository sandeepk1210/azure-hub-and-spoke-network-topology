# Given the HUB will require a virtual network gateway so that traffic can be routed between the spoke
# Public IP for the Virtual Network Gateway
resource "azurerm_public_ip" "vpn_gateway_ip" {
  name                = "vnetgwip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.vpn_gateway_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  type                = "Vpn"        # Options: Vpn, ExpressRoute
  vpn_type            = "RouteBased" # Options: PolicyBased, RouteBased
  sku                 = var.gateway_sku
  active_active       = false

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vpn_gateway_ip.id
    subnet_id            = azurerm_subnet.hub_vnet_subnet["GatewaySubnet"].id
  }

  tags = local.common_tags
}
