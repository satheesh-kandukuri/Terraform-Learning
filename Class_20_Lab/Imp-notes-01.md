### terraform import 

```terraform import``` is a command in the Terraform CLI used to bring existing infrastructure resources, 
which were not originally created or managed by Terraform, under Terraform's management.
It imports the pre-existing cloud resources into the Terraform state.

- Before Terraform was adopted, your organization had an **existing infrastructure** created using Python scripts, Powershell, **manual processes**, or other tools.
  **Importing these resources allows you to start managing them with Terraform**.
- Bringing unmanaged resources under Terraform management – your company may have started its infrastructure adventure by doing ClickOps or
  by using some custom scripts. Now, to bring everything under Terraform, terraform import will be the solution.
- Terraform can work on **hybrid environments**, allowing you to manage resources across different cloud providers and on-premises infrastructure.

- Terraform expects that each remote object is bound to only one resource address and you should import each remote object to only one terraform resource address.
  - A resource address is like aws_instance.my_ec2.
  - Terraform does not allow mapping the same remote object (say, EC2 instance i-12345) to multiple resource addresses.
  - If you try, the state becomes inconsistent and Terraform can’t determine which config “owns” the object.
 
- If you import the same object multiple times, the terraform state will become inconsistent, and you may encounter errors when trying to manage the resource.
  - importing the same object to multiple resources in the state file creates duplicate ownership.
  - On the next plan or apply, Terraform may try to delete or recreate resources incorrectly → leading to errors.
 
- Terraform import can only import the resources into the state file, not the configuration files.
  - Type 1 CLI import:
    -  The terraform import command only updates state.
    -  It does not write the .tf configuration.
    -  You must manually ensure your .tf config matches the real-world resource.
    -  Otherwise, terraform plan will show drift and possibly try to change or destroy the resource.
- Before we run the terraform import command, we must manually write the resource configuration block for that resource in the .tf file
  -   ```hcl
      resource "aws_instance" "my_ec2" {}
      ```
      must exists before:

      ```hcl
      terraform import aws_instance.my_ec2 i-1234567890abcdef
      ```
  - If the resource block isn’t present, Terraform has nowhere to map the import.
 
Now here we have 2 types of ```import``` options are available:

### Type 1: Legacy ```terraform import``` (CLI-based)

### Type 2: Declarative ```import {}``` block (since Terraform 1.5)

Type 1: Legacy terraform import (CLI-based)
```hcl
resource "<PROVIDER>_<RESOURCE_TYPE>" "<RESOURCE_NAME>" {
  # Configuration options
}
```
How it works:
- You first declare the resource in .tf files.
- Then run the CLI command:
```hcl terraform import aws_instance.my_ec2 i-1234567890abcdef```
- Terraform will map the existing resource (```i-1234567890abcdef```) to the state entry ```aws_instance.my_ec2```.

Characteristics:
- Two-step process (write config + run command).
- The import action is not stored in configuration – it’s a one-off CLI command.
- If someone else clones your repo, they don’t know how you imported unless you document it.

Type 2: Declarative import {} block (since Terraform 1.5)
```hcl
import {
  to = aws_instance.my_ec2
  id = "i-1234567890abcdef"
}
```
How it works:
- You declare the resource (aws_instance.my_ec2) in .tf and declare how it should be imported in the same code.
- Then just run:
```hcl
terraform plan
terraform apply
```
- Terraform will automatically import during apply.
Characteristics:
- Config-driven import (documented in .tf code).
- Makes imports repeatable and collaborative (works for teams, CI/CD).
- No need to run extra CLI commands.
- Easier to track in version control.

**Which is more useful?**

- Type 1 (CLI) → useful for quick, ad-hoc imports when experimenting.

- Type 2 (import {} block) → more useful in real projects, teams, or automation, because:
  - Keeps import logic inside .tf files.
  - Repeatable and auditable.
  - Works in pipelines (no manual commands needed).

👉 In modern Terraform (>=1.5), ```Type 2``` is the recommended approach.
