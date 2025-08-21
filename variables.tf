variable "resource_group_name_prefix" {
  type        = string
  default     = "vm"
  description = "Prefix for the resource group name."
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region for all resources."
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine."
}

variable "vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "Size of the VM (e.g., Standard_DS2_v2)."
}

variable "is_windows_image" {
  type        = bool
  default     = false
  description = "Whether to deploy a Windows (true) or Linux (false) VM."
}

variable "windows_sku" {
  type        = string
  default     = "2019-Datacenter"
  description = "SKU for Windows VM (e.g., 2019-Datacenter)."
}

variable "linux_sku" {
  type        = string
  default     = "20.04-LTS"
  description = "SKU for Linux VM (e.g., 20.04-LTS)."
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM."
  sensitive   = true
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to attach the VM NIC to."
}

variable "public_ip_enabled" {
  type        = bool
  default     = true
  description = "Whether to assign a public IP to the VM."
}

variable "os_disk_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Type of managed disk (e.g., Standard_LRS, Premium_LRS)."
}

variable "os_disk_size_gb" {
  type        = number
  default     = 128
  description = "Size of the OS disk in GB. Can be increased without recreation."
}

variable "enable_managed_identity" {
  type        = bool
  default     = false
  description = "Enable system-assigned managed identity for the VM."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources."
}
