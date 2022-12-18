prefix        = "dev"
disk_size_gb  = 30
client_secret = "7vI8Q~-7THGhUC4Q3~gm1UsV9UFueWJXlHVrDdyz"
environment   = "dev"

# VNET related
terraform_test_vnet_name = "${prefix}-terraform-test-vnet"
terraform_test_vnet_address_space   = ["10.11.0.0/16", "192.168.11.0/24"]
subnet_names    = ["testsubnet1", "testsubnet2", "testsubnet3"]
subnet_prefixes = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
nsg_ids = {
  testsubnet1 = "test_nsg1"
  testsubnet2 = "test_nsg1"
  testsubnet3 = "test_nsg1"
}

