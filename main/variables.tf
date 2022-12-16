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
variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "testvnet"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet1", "subnet2", "subnet3"]
}