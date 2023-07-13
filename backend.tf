terraform {
  backend "azurerm" {
    subscription_id      = "f3e5381e-28a5-4ede-a3c9-6850bac5232f"
    resource_group_name  = "sita-sig-eastus-terraform-storage"
    storage_account_name = "sigterraformstorage"
    container_name       = "terraform"
    key                  = "sig-statefile.state"
  }
}