terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.97.1"
    }
     spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.10.0"
    }
  }
  

  backend "remote" {

    hostname     = "spacelift.io" 

    organization = "devin-earl"    



    workspaces {

      name = "test-stack" 

    }

  }

}

provider "azurerm" {
   features {}

#   client_id       = var.ARM_CLIENT_ID
#   client_secret   = var.ARM_CLIENT_SECRET
#   tenant_id       = var.ARM_TENANT_ID
#   subscription_id = var.ARM_SUBSCRIPTION_ID
}
resource "azurerm_resource_group" "example" {
  name     = var.acr_rg_name
  location = var.acr_location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = var.acr_sku
  admin_enabled       = false
}
provider "spacelift" {
  api_key_endpoint = "https://devin-earl.app.spacelift.io"
  api_key_id       = var.spacelift_key_id
  api_key_secret   = var.spacelift_key_secret
}