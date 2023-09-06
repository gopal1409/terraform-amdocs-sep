##3create a vnet
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name
  address_space       = ["10.0.0.0/16"]
 # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = "Production"
  }
}
#create subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet-1"
  resource_group_name  = azurerm_resource_group.myrg1.name
  ###the subnet need to be inside vnet
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
##create public ip
resource "azurerm_public_ip" "mypublicip" {
  ###add an explicit dependency to have this resource created only after vnet and subnet resource are created
  ##terraform have an metqa argument called as dependson
  ###in depends on the format will be resource and resource ref
  depends_on = [ azurerm_virtual_network.myvnet,azurerm_subnet.mysubnet ]
  name                = "mypublicip-1"
  resource_group_name = azurerm_resource_group.myrg1.name
  location            = azurerm_resource_group.myrg1.location
  allocation_method   = "Static" ##dynamic
  domain_name_label = "app1-vm-${random_string.random.id}"

  tags = {
    environment = "Production"
  }
}
##create network interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id 
    ##nic card will also have an public ip
  }
}