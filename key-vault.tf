# Random password
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

# Random string for unique Key Vault name
resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                        = "kv-${lower(random_string.unique.result)}"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  enabled_for_disk_encryption = true

  sku_name = "standard"

  # Existing access policy for the current client
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Create", "Get", "List", "Update", "Delete", "Purge", "Recover", "GetRotationPolicy", "SetRotationPolicy", "WrapKey", "UnwrapKey"]
    secret_permissions = ["Get", "Set", "Delete", "List", "Restore"]
  }
}

# Store Admin Password in Key Vault
resource "azurerm_key_vault_secret" "admin_password" {
  name         = "vm-admin-password"
  value        = random_password.admin_password.result
  key_vault_id = azurerm_key_vault.kv.id
}
