# Unit 4 - Red, Green, REFACTOR

The TDD concept of red, green, refactor can be applied to the work we do with Terraform.
I like to think of `terraform plan` as "run my tests".
The resulting output from the plan helps us build mental assertions about the changes we've made to the Terraform configuration in front of us.
So far, we've participated in the red and green behaviors of TDD.

- Let's refactor our Terraform blocks/files for clarity.
  - To start, ensure we're in a green state.
    Run `terraform plan`.
    You should see a plan that reports `No changes. Your infrastructure matches the configuration.`
    If you don't, tweak your configuration until you do.
  - Create a file called `providers.tf` and move the `terraform` and `provider` blocks from `main.tf` into this new file.
  - Run `terraform plan`.
    You should see `No changes. Your infrastructure matches the configuration.`
  - Create a file called `variables.tf` and move the `variable` block from `main.tf` into this new file.
  - Run `terraform plan`.
    You should see `No changes. Your infrastructure matches the configuration.`
    At this point, you should only have the `resource` block in the `main.tf` file.

- What did we learn?
  - We learned that simple refactoring, like moving blocks to different files for better organization, results in non-breaking behavior.
    Terraform doesn't care which files contain the configuration blocks.
    Terraform builds its dependency graph based on all files that end in `.tf` in the current working directory, regardles of filename.
