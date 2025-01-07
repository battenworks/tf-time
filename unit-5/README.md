# Unit 5 -

Let's see what happens when we rename our resource group.
- Change the `name` argument of our resource group from `rg-tf-time` to `rg-tf-time-2`.
- Run a `terraform apply`.
- Notice that Terraform wants to destroy the original resource group and create a new one.
- Terraform has to abide by the rules of the cloud and the cloud provider, with regards to immutability.
In Azure, you cannot simply rename a resource group (not all Azure resources have this constraint), so Terraform must comply with that rule. Apply the change.

Now, let's look at another rename operation.
Since we renamed the resource group in Azure, you'll notice that the name of the resource block in our config doesn't line up any longer.
Our Azure resource group is named `rg-tf-time-2`, but our resource block is named `tf_time`.
- Change the resource block name from `tf_time` to `tf_time_2`.
- Run `terraform plan`.
- Once again, we see that Terraform wants to destroy and recreate the resource group.
Why would it do this when we aren't actually changing the Azure resource?
It's time to talk about Terraform state.
