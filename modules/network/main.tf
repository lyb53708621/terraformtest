resource "azurerm_virtual_network" "testvnet" {
  name                = "${var.prefix}-testvnet"
  address_space       = ["10.101.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "testsubnet" {
  name                 = "${var.prefix}-testsubnet"
  resource_group_name  = azurerm_virtual_network.testvnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.testvnet.name
  address_prefixes     = ["10.101.0.0/24"]

}

