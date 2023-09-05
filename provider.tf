# first we need to provide the provider block
provider "azurerm" {
  features {}
  ##take all the default feature from the cloud service provider. 
  #i create a vm and delete the vm. the hdd storage will be also delete.
}
##3as per terraform 14 version we are providing this provider

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false 
      ##it will ensure when the vm is destro disk is not delete. 

    }
  }
  alias = "provider2-westus"
  #cleintid="XXXXX"
  ##clientsecret = "YYYY"
  #environment = "us2"
  #"subscription_id"="1221212"
}
terraform {
  required_providers {
    azurerm={
      source = "hashicorp/azurerm"
      #version = "2.40.0"
    } 
  }
}
###but if you add another provider. random generator local null data
###we created this block and inside this provider block we have given a cloud service provider name
#erraform init it will download the plugin required to communicate with the cloud service provider. 
###when you want to share the code never share this plugin. 
#if someone want to use the code redo terraform init

resource "azurerm_resource_group" "rg" {
  ###change the resource group name
  name     = "myrg-gopal"
  location = "eastus"
}

