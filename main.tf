# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.16.0"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = "storage-rg"
    storage_account_name = "storage20205"
    container_name       = "tfstate"
    key                  = "terraform-blob.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg"
  location = "eastus2"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tfdemovnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg
  ]
  tags = {
    Environment = "Terraform Getting Started"
    Team        = "DevOps"
  }
}

resource "azurerm_resource_group" "demo-rg" {
  name     = var.rg_name
  location = var.rg_location_name
}


resource "azurerm_virtual_network" "vnet2" {
  name                = "tfdemovnetdemo"
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location_name
  resource_group_name = var.rg_name
  depends_on = [
    azurerm_resource_group.demo-rg
  ]
  tags = {
    Environment = "Demo vnet"
    Team        = "DevOps"
  }
}



resource "azurerm_service_plan" "app_plan" {
  name                = "app-service-plan-free"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "F1"
  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_windows_web_app" "mjtfdemoapp" {
  name                = "mjtfdemoapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus2"
  service_plan_id     = azurerm_service_plan.app_plan.id
  site_config {
    always_on = false
  }
  depends_on = [
    azurerm_service_plan.app_plan
  ]
}