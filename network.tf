##3create a vnet
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name
  address_space       = ["10.0.0.0/16"] #it will give me more than 65 thousand host
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
  address_prefixes     = ["10.0.0.0/24"] #@i can attach 256 host. 
}
##create public ip
resource "azurerm_public_ip" "mypublicip" {
  ###add an explicit dependency to have this resource created only after vnet and subnet resource are created
  ##terraform have an metqa argument called as dependson
  ###in depends on the format will be resource and resource ref
  ##3count is an meta argument
  ###count need to do iteration
  count = 2
  depends_on = [ azurerm_virtual_network.myvnet,azurerm_subnet.mysubnet ]
  name                = "mypublicip-1-${count.index}"
  resource_group_name = azurerm_resource_group.myrg1.name
  location            = azurerm_resource_group.myrg1.location
  allocation_method   = "Static" ##dynamic
  domain_name_label = "app1-vm-${count.index}-${random_string.random.id}"

  tags = {
    environment = "Production"
  }
}
##create network interface
resource "azurerm_network_interface" "example" {
  count = 2 
  name                = "example-nic-${count.index}"
  location            = azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = element(azurerm_public_ip.mypublicip[*].id,count.index) 
    ##nic card will also have an public ip
  }
}