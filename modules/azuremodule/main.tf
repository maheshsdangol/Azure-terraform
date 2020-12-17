terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rf_blobstore"
        storage_account_name = "tfstorageaccount1"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
 	subscription_id      = "338fe939-8530-4e88-a944-fbeda4421ddd"
        tenant_id            = "88fdd5f5-af3e-46af-91a4-8a77fa86e04e"
  }
}


resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "eastus"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "msingh977"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "msingh977/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}
