variable "business_unit" {
  description = "Business Unit Name"
  type=string #mnumeric string(list)
  default = "hr"
}
variable "environment" {
  description = "environment name"
  type=string #mnumeric string(list)
  default = "dev"
}

variable "resource_group_name" {
  description = "resource group name"
  type=string #mnumeric string(list)
  default = "myrg"
}

variable "resource_group_location" {
  type = string
  default = "East US"
}

variable "virtual_network_name" {
  type = string 
  default = "myvnet"
}
variable "subnet_name" {
  description = "virtual network subnet name"
  type = string
  default = "mysubnet"
}