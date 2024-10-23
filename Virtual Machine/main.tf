# Use an existing resource group
data "azurerm_resource_group" "existingResourceGroup" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "azVNet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = data.azurerm_resource_group.existingResourceGroup.location
  resource_group_name = data.azurerm_resource_group.existingResourceGroup.name
}

resource "azurerm_subnet" "azSubnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.existingResourceGroup.name
  virtual_network_name = azurerm_virtual_network.azVNet.name
  address_prefixes     = var.subnet_prefix
}

resource "azurerm_network_interface" "azNIC" {
  name                = "example-nic"
  location            = data.azurerm_resource_group.existingResourceGroup.location
  resource_group_name = data.azurerm_resource_group.existingResourceGroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "azVM" {
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.existingResourceGroup.name
  location            = data.azurerm_resource_group.existingResourceGroup.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.azNIC.id,
  ]

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}