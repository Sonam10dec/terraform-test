# Generate SSH Key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-policy-practice"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "vnet-policy-practice"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    environment = "practice"
    purpose     = "policy-as-code"
  }
}

# Subnet
resource "azurerm_subnet" "example" {
  name                 = "subnet-internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Interface
resource "azurerm_network_interface" "example" {
  name                = "nic-vm-policy-practice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "practice"
    purpose     = "policy-as-code"
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "example" {
  name                = "vm-policy-practice"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    environment = "practice"
    purpose     = "policy-as-code"
  }
}
