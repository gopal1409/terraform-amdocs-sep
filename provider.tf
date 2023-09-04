# first we need to provide the provider block
provider "azurerm" {
  version = "=2.36.0"
  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
    ###change the resource group name
  name = "myrg-gopal"
  location = "eastus"
}

