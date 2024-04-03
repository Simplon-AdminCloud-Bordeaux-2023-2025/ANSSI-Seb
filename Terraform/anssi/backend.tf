terraform {
  backend "azurerm" {
    resource_group_name  = "Sebastien_K"
    storage_account_name = "sebastienk"
    container_name       = "tfstate"
    key                  = "Sebastien_K/terraform.tfstate"
  }
}