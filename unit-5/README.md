# Unit 5 - A Resource Group By Any Other Name

Let's see what happens when we rename our resource group.
- Change the `name` argument of our resource group from `rg-tf-time` to `rg-tf-time-2`.
- Run a `terraform apply`.
- Notice that Terraform wants to replace the resource group in Azure.
  Terraform must abide by the rules of the cloud and the cloud provider, with regards to immutability.
  In Azure, you cannot simply rename a resource group (not all Azure resources have this constraint), so Terraform must comply with that rule.
- Apply the change.

Now, let's look at another rename operation.
Since we renamed the resource group in Azure, you'll notice that the name of the resource block in our config doesn't line up any longer.
Our Azure resource group is named `rg-tf-time-2`, but our resource block is named `tf_time`.
- Change the resource block name from `tf_time` to `tf_time_2`.
- Run `terraform plan`.
- Once again, we see that Terraform wants to destroy and recreate the resource group.
Why would it do this when we aren't actually changing the Azure resource?
It's time to talk about Terraform state.

Terraform maintains its relationship with the resources it manages in a state file.
By default, the file is called `terraform.tfstate` and it exists in the root of the current working directory.
The state file uses JSON syntax to store the last applied state of the system.
Terraform uses the `type` and `name` of each resource block as a composite primary key to help track state changes.

```
{
  ...

  "resources": [
    {
      "mode": "managed",
      "type": "azurerm_resource_group",   <- KEY
      "name": "tf_time",                  <- KEY
      "provider": "provider[\"registry.terraform.io/hashicorp/azurerm\"]",
      "instances": [
        {
          ...

          details about your resource here

          ...
        }
      ]
    }
  ],
  
  ...
}

```

When we renamed the Azure resource, the changes were persisted to the `instances` collection in the state file you see above.
The rename we are attempting now is a change to the primary key in the state file, and requires a different approach.
What we're really trying to do is change the key without changing the actual Azure resource, so a destroy/recreate is not the proper move.

What we really want to do is something we'll call a "state move".
The command syntax is: `terraform state mv <from> <to>`, and the details of the "from" and "to" are in the output of the last plan you ran.
In the output, the original key is `azurerm_resource_group.tf_time` and the new key is `azurerm_resource_group.tf_time_2`.

```
Terraform will perform the following actions:
    |---         FROM         ---|
  # azurerm_resource_group.tf_time will be destroyed
  # (because azurerm_resource_group.tf_time is not in configuration)
  - resource "azurerm_resource_group" "tf_time" {
      - id         = "/subscriptions/<blargh>/resourceGroups/rg-tf-time-2" -> null
      - location   = "eastus2" -> null
      - name       = "rg-tf-time-2" -> null
        # (1 unchanged attribute hidden)
    }
    |---          TO            ---|
  # azurerm_resource_group.tf_time_2 will be created
  + resource "azurerm_resource_group" "tf_time_2" {
      + id       = (known after apply)
      + location = "eastus2"
      + name     = "rg-tf-time-2"
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```

So, let's move it.
- Run `terraform state mv azurerm_resource_group.tf_time azurerm_resource_group.tf_time_2`
- Run `terraform plan`.
  You should see `No changes. Your infrastructure matches the configuration.`

What did we learn?
- Terraform abides by the lifecycle rules imposed by the cloud.
  This sometimes forces Terraform to destroy and create infrastructure.
- Terraform stores its work in a state file and tracks state using unique keys.
- We can manipulate the state file keys to refactor our Terraform config without modifying our cloud resources.
