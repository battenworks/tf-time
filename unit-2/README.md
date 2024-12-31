# Unit 2 - I Want a Resource Group

- Creating a resource group incurs no Azure costs, so let's start with one of those.
  Everything in Azure needs to be put into a resource group anyway.
  - In your `main.tf` file, add the following `resource` block to define a new Azure resource group.

  ```terraform
  resource "azurerm_resource_group" "tf_time" {
    name     = "rg-tf-time"
    location = "eastus2"
  }
  ```

  - Run `terraform validate`.
  - You should see `Success! The configuration is valid.`
    If you don't, use this as an opportunity to understand and fix the errors you see.
  - Run `terraform plan`.
  - Ruh-roh.
    You should see an error for `Invalid provider configuration`, which makes sense since we have provided no provider configuration.
    We have only required that Terraform download the provider (the `required_providers` snippet from Unit 1).
  - In your `main.tf` file, add the following blocks to configure the correct Azure subscription to work with.

  ```terraform
  variable "subscription_id" {
    description = "The ID of your Azure subscription"
    nullable    = false
    type        = string
  }

  provider "azurerm" {
    subscription_id = var.subscription_id

    features {}
  }
  ```

  - Run `terraform plan` again.
  - You will be prompted for a subscription_id.
    Supply your Azure Subscription ID and the plan will continue.
  - You should see a plan that intends to `Plan: 1 to add, 0 to change, 0 to destroy.`
    If you see an error, it is most likely because you're trying to create a resource group with a name that already exists in the target subscription.
    Change the `name` argument of your `azurerm_resource_group.tf_time` resource (on, or about, line 10 of `main.tf`) until you get a clean plan.
  - Once you have a clean plan to add your resource group, run `terraform apply`.
    It will re-run the plan from above, but will pause to confirm you want the change to occur.
    Confirm with `yes`.
  - You should see `Apply complete! Resources: 1 added, 0 changed, 0 destroyed.`
    If you don't, use this as an opportunity to understand and fix the errors you see.
  - Now that we have our first Azure resource under Terraform control, you can modify the `azurerm_resource_group.tf_time` arguments to see what behavior the Terraform CLI produces in response to those changes.

- What did we learn?
  - We validated that our Terraform configuration meets minimum standards with the `terraform validate` command.
    It's basically a linter without the stylistic component.
  - We encountered an error and resolved it.
  - We planned our infrastructure changes with the `terraform plan` command.
  - We created our first Azure resource with the `terraform apply` command.
    Maybe we tweaked it a bit for fun.
