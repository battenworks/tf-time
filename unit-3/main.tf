terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

resource "azurerm_resource_group" "tf_time" {
  name     = "rg-tf-time"
  location = "eastus2"
}

variable "subscription_id" {
  description = "The ID of your Azure subscription"
  nullable    = false
  type        = string
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}
