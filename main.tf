# Configuring the Azure provider with version 4.23.0
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.23.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group for the VM
resource "azurerm_resource_group" "vm_rg" {
  name     = "${var.resource_group_name_prefix}-rg"
  location = var.location
}

# Network interface for the VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_enabled ? azurerm_public_ip.vm_public_ip[0].id : null
  }
}

# Optional public IP
resource "azurerm_public_ip" "vm_public_ip" {
  count               = var.public_ip_enabled ? 1 : 0
  name                = "${var.vm_name}-pip"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.vm_name}-${random_string.dns_label.result}"
}

# Random string for unique DNS label
resource "random_string" "dns_label" {
  length  = 8
  special = false
  upper   = false
}

# Virtual Machine (Windows or Linux)
resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.vm_rg.location
  resource_group_name   = azurerm_resource_group.vm_rg.name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_type
    disk_size_gb      = var.os_disk_size_gb  # Supports resizing without recreation in 4.23.0 (web:2)
  }

  storage_image_reference {
    publisher = var.is_windows_image ? "MicrosoftWindowsServer" : "Canonical"
    offer     = var.is_windows_image ? "WindowsServer" : "UbuntuServer"
    sku       = var.is_windows_image ? var.windows_sku : var.linux_sku
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = !var.is_windows_image
  }

  os_profile_windows_config {
    enable_automatic_updates = var.is_windows_image
  }

  # Optional managed identity
  identity {
    type = var.enable_managed_identity ? "SystemAssigned" : "None"
  }

  # Tags for resource management
  tags = var.tags
}
