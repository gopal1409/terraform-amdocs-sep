# first we need to provide the provider block
provider "azurerm" {
  features {}
}
##3as per terraform 14 version we are providing this provider
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

