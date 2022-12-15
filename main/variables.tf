variable "prefix" {
  type    = string
  default = "prd"
}

variable "environment" {
  type    = string
  default = "prd"
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