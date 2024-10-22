variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "resource-group-tf"
}

variable "resource_group_location" {
  description = "Azure location where the Resource Group will be created"
  type        = string
  default     = "Central India"
}
