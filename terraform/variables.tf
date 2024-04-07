// ========================== Azure Container Registry (ACR) ==========================

variable "acr_name" {
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
  type        = string
  nullable = false
}
variable "acr_rg_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  type        = string
  nullable = false
}
variable "acr_location" {
  description = "Location in which to deploy the Container Registry"
  type        = string
  default     = "East US"
  nullable = false
}
variable "acr_admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  type        = string
  default     = false
  nullable= true
}
variable "acr_sku" {
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "The container registry sku is invalid."
  }
  nullable = true
}
variable "acr_georeplication_locations" {
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = ["Central US", "East US"]
  nullable = true
}
variable "acr_log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 7
}
variable "acr_tags" {
  description = "(Optional) Specifies the tags of the ACR"
  type        = map(any)
  default     = {}
}
variable "data_endpoint_enabled" {
  description = "(Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU."
  default     = true
  type        = bool
}
variable "spacelift_key_id" {
  type = string
}
variable "spacelift_key_secret" {
    type = string
  
}
# variable "ARM_CLIENT_ID" {
#     type = string
  
# }
# variable "ARM_CLIENT_SECRET" {
#     type = string
  
# }
# variable "ARM_SUBSCRIPTION_ID" {
#     type = string
  
# }
# variable "ARM_TENANT_ID" {
#     type = string
  
# }
variable "azure_app_service_name" {
  description = "Name of Azure App Service"
   nullable = false
}