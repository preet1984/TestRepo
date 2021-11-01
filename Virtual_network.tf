#Resource-2: Create Virtual Network

resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  location            = azurerm_resource_group.myRG1.location
  resource_group_name = azurerm_resource_group.myRG1.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    "name" = "myvnet-1"
    # "environment" = "Dev"
  }
}

#Resource-3: Create Subnet

 resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet-1"
  resource_group_name  = azurerm_resource_group.myRG1.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
 }

# Resource-4: Create Public IP Address

 resource "azurerm_public_ip" "mypublicip" {
  name                = "mypublicip-1"
  resource_group_name = azurerm_resource_group.myRG1.name
  location            = azurerm_resource_group.myRG1.location
  allocation_method   = "Static"

  tags = {
    environment = "Dev"
  }
}

# Resource-5: Create Network Interface

resource "azurerm_network_interface" "myvmnic" {
  name                = "myvmnic"
  location            = azurerm_resource_group.myRG1.location
  resource_group_name = azurerm_resource_group.myRG1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id
  }
}

