resource "azurerm_linux_virtual_machine" "mylinuxvm" {
  for_each            = toset(["vm1", "vm2"])
  name                = "mylinuxvm-1-${each.key}"
  resource_group_name = azurerm_resource_group.myrg1.name
  location            = azurerm_resource_group.myrg1.location
  size                = "Standard_DS1_v2"
  admin_username      = "azureyser"
  ###splat operator using element
  ##count index is the length function 
  network_interface_ids = [azurerm_network_interface.example[each.key].id]
  admin_ssh_key {
    username = "azureyser"
    ##3root of the user directory
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }
  os_disk {
    name                 = "osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/app-script.sh")
}