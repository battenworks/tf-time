# Unit 1 - I Got Nothing

First try!
- Start with an empty directory.
- Create a file called `main.tf` with the following `terraform` block, to set our provider requirement.

```terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}
```

- Run `terraform init`
- Inspect the resulting `.terraform` directory.
  Notice that the provider matching our `version` constraint has been downloaded locally.
  Terraform downloads all providers and modules (you'll learn about modules later) into this directory as a local cache.
- Inspect the resulting `.terraform.lock.hcl` file.
  Notice that the version of the downloaded provider has been recorded here.

What did we learn?
- We referenced a provider from the [Hashicorp registry](https://registry.terraform.io).
- We initialized our Terraform configuration with the `terraform init` command.
- We saw that Terraform creates a local cache to work with.
- We saw that Terraform uses a lock file to prevent provider version drift.
