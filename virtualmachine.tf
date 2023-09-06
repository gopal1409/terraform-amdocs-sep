resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  count = 2
  name = "mylinuxvm-1-${count.index}"
  resource_group_name = azurerm_resource_group.myrg1.name
  location = azurerm_resource_group.myrg1.location
  size = "Standard_DS1_v2"
  admin_username = "azureyser"
  network_interface_ids = [element(azurerm_network_interface.example[*].id, count.index)]
  admin_ssh_key {
    username = "azureyser"
    ##3root of the user directory
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }
  os_disk {
    name = "osdisk-${count.index}"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/app-script.sh")
  
}