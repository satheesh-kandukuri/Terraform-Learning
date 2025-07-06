# Terraform-Learning

```bash
Practice_Lab/
└── AV-D3/
    ├── main.tf                # Root module: provider and module call
    ├── variables.tf           # Root variables (declared here)
    ├── terraform.tfvars       # (Optional) Values for root variables
    └── modules/
        └── ec2/
            ├── main.tf        # Module: defines aws_instance
            └── variables.tf   # Module variables (declared here)
```

Declare variables in both root and module if you want to pass them through.

** How It Works**

- ```Root variables.tf``` declares variables for the root module.
- ```terraform.tfvars``` (or CLI input) provides values for those variables.
- ```main.tf``` in the root passes those variables to the module.
-``` modules/ec2/variables.tf``` declares the variables the module expects.
- ```main.tf``` uses those variables to create resources.

Declare variables in both root and module.
Pass variables from root to module in the module block.

The ```terraform.tfvars``` file provides values for variables, but you must still declare those variables in your root module using variable blocks (usually in a variables.tf file).

terraform.tfvars only supplies values; it does not declare variables.

- **variables.tf declares variables.**
- **terraform.tfvars provides values for those variables**.


**```variables.tf``` was already declared in ```modules/ec2/``` right ? Why again need to define ```variables.tf``` in Root folder ?**

GitHub Copilot
Yes, you did declare the variables in ```modules/ec2/variables.tf```, but you also need to declare them in the root module (```AV-D3/variables.tf```) if you want to use ```var.ami_value``` and ```var.instance_type_value``` in your ```root main.tf```

**Why?**

The variables in ```modules/ec2/variables.tf``` are only visible inside the module.
The ```root module (main.tf)``` needs its own variable declarations to use ```var.ami_value``` and ```var.instance_type_value```

- **If you hardcode values directly in the module block (like in your current main.tf), you do not need to declare those variables in AV-D3/variables.tf.**
- **If you want to use variables (like ami_value = var.ami_value), then you must declare them in AV-D3/variables.tf.**


When to Use ```variables.tf``` in** Root **
If you want to make your configuration flexible and reusable, you can declare variables in ```AV-D3/variables.tf``` and reference them in your ```main.tf```:


```hcl
module "ec2" {
    source              = "./modules/ec2"
    ami_value           = var.ami_value
    instance_type_value = var.instance_type_value
}
```

And then declare those variables in ```AV-D3/variables.tf```
