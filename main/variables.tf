variable "prefix" {
  type    = string
  default = "dev"
}

variable "environment" {
  type    = string
  default = "dev"
}
variable "location" {
  type    = string
  default = "eastasia"
}

variable "vm_username" {
  type    = string
  default = "azureuser"
}

variable "vm_password" {
  type    = string
  default = "Testceph123!"
}

variable "disk_size_gb" {
  type    = number
  default = 20
}

variable "client_secret" {
  type = string
}

# VNET related
variable "terraform_test_vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "testvnet"
}

variable "terraform_test_vnet_address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "terraform_test_vnet_subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet1", "subnet2", "subnet3"]
}

variable "terraform_test_vnet_subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
