resource_group_name_prefix = "myvm"
location                  = "eastus"
vm_name                   = "my-vm"
vm_size                   = "Standard_DS2_v2"
is_windows_image          = true
admin_username            = "adminuser"
admin_password            = "ComplexP@ssw0rd!"
subnet_id                 = "/subscriptions/your-subscription-id/resourceGroups/your-rg/providers/Microsoft.Network/virtualNetworks/your-vnet/subnets/your-subnet"
public_ip_enabled         = true
os_disk_type              = "Standard_LRS"
os_disk_size_gb           = 128
enable_managed_identity   = true
tags                      = { environment = "prod" }
