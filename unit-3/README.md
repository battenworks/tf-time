# Unit 3 - I'm Tired of Supplying Subscription ID

Supplying the subscription ID each time you run a Terraform command is getting old.
You _could_ simply add the subscription ID string in the `provider` block, but then it would get committed to source control.
So, what to do?

There are a few ways to supply variable values to the Terraform CLI.
You've experienced one of them already.
Let's look at some others.

1. Use the `-var` flag
    - There are 2 ways to do this.
    - Run `terraform plan -var subscription_id=<your subscription id>`.
      You should see a plan that reports `No changes. Your infrastructure matches the configuration.`
    - Run `terraform plan -var=subscription_id=<your subscription id>`.
      You should see `No changes. Your infrastructure matches the configuration.`
    - Notice the equals sign immediately following the `-var` flag in the second example.
      Both commands are equivalent.
      This rule is universal to all flags you supply to the CLI.

2. Use a variables file
    - Create a new file called `local.tfvars` and set your `subscription_id` as follows.

    ```
    subscription_id = "<your subscription id>"
    ```

    - Run `terraform plan -var-file local.tfvars`.
      You should see `No changes. Your infrastructure matches the configuration.`
    - Notes
        - `.tfvars` files declare variables in the format `<key> = <value>` and can have an unlimited number of variables.
        - You can encapsulate multiple variables in one file.
        - The `.tfvars` file extension is commonly included in `.gitignore` files, so you can keep sensitive values out of source control.
        - You can find an example `.gitignore` file in the root of this repo.

3. Use an automatic variables file
    - Rename your variables file to `local.auto.tfvars`.
    - Run `terraform plan`.
      You should see `No changes. Your infrastructure matches the configuration.`
    - Notes
        - You no longer need to use the `-var-file` flag to reference your variables file.
        - Since your variables file still ends in `.tfvars`, the same `.gitignore` rules apply.

- What did we learn?
  - There are multiple ways of supplying variable values to the CLI.
  - We can supply values in an automated fashion while keeping sensitive values out of source control.
