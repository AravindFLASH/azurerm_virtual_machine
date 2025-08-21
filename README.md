Azure Virtual Machine Module

This Terraform module deploys an Azure Virtual Machine (Windows or Linux) with associated resources (resource group, network interface, optional public IP). It is compatible with the azurerm provider version 4.23.0.

Requirements





Terraform >= 1.0



azurerm provider = 4.23.0



random provider ~> 3.0



Existing virtual network and subnet for NIC attachment

Usage

module "vm" {
  source  = "./modules/azurerm-vm"
  resource_group_name_prefix = "myvm"
  location                  = "eastus"
  vm_name                   = "my-vm"
  vm_size                   = "Standard_DS2_v2"
  is_windows_image          = true
  admin_username            = "adminuser"
  admin_password            = "ComplexP@ssw0rd!"
  subnet_id                 = "/subscriptions/.../subnets/my-subnet"
  public_ip_enabled         = true
  os_disk_type              = "Standard_LRS"
  os_disk_size_gb           = 128
  enable_managed_identity   = true
  tags                      = { environment = "prod" }
}

Inputs





resource_group_name_prefix: Prefix for resource group name (default: "vm").



location: Azure region (default: "eastus").



vm_name: Name of the VM.



vm_size: VM size (default: "Standard_DS2_v2").



is_windows_image: True for Windows, false for Linux (default: false).



windows_sku: Windows image SKU (default: "2019-Datacenter").



linux_sku: Linux image SKU (default: "20.04-LTS").



admin_username: Admin username.



admin_password: Admin password (sensitive).



subnet_id: Subnet ID for NIC.



public_ip_enabled: Enable public IP (default: true).



os_disk_type: Disk type (default: "Standard_LRS").



os_disk_size_gb: OS disk size in GB (default: 128).



enable_managed_identity: Enable system-assigned managed identity (default: false).



tags: Resource tags (default: {}).

Outputs





vm_id: VM resource ID.



public_ip_address: Public IP address (if enabled).



private_ip_address: Private IP address.



vm_name: VM name.

Notes





Compatible with azurerm provider 4.23.0, supporting features like disk resizing without recreation (web:2).



Use with the AutoGen Terraform agent system to scan for deprecated arguments and apply fixes.
