resource "azurerm_resource_group" "myrg1" {
  name = "myrg-1-gopal"
  location = "East US"
}

resource "azurerm_resource_group" "myrg2" {
  name = "myrg-2-gopal"
  location = "West US"
  provider = azurerm.provider2-westus
}