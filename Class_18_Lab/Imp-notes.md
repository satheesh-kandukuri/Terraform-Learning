### 🔹 What are Terraform Locals?

- **Locals** are like **temporary variables inside your Terraform code**.
- They help you avoid repeating values and make your code cleaner and easier to manage.
- Defined inside a ```locals {}``` block.

```hcl
locals {
  environment = "dev"
  project     = "myapp"
  common_tags = {
    Project     = "myapp"
    Environment = "dev"
    Owner       = "Satheesh"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "${local.project}-${local.environment}-bucket"

  tags = local.common_tags
}

```
- Instead of hardcoding ```"dev"``` or ```"myapp"``` multiple times, we put them in locals.
- To use them → ```local.name``` (e.g., ```local.environment```).

### 🔹 Why Use Locals?

✅ Avoid duplication:
- If you have 20 resources that all need the same project or environment name → just define once in locals.

✅ Improve readability:
- Your code is shorter, cleaner, and easy to understand.

✅ Maintain consistency:
- If tomorrow "dev" changes to "staging", you just update once in locals, not in 20 places.

✅ Reusable logic:
- You can even use locals to create computed values.
- What are Computed Values in Locals?
  - Computed values mean locals don’t always have to be hardcoded strings/numbers.
  - You can use expressions, functions, and combinations of variables/locals to create new values.
  - Works great with loops, functions, conditionals, and maps.
  - This makes your Terraform code dynamic.
- In short: **```Computed locals = using functions, conditionals, loops, and expressions inside locals {} to create smart reusable values.```**
```hcl
Examples of Computed Locals

1️⃣ String Interpolation (Joining values)
locals {
  environment = "prod"
  project     = "ecommerce"
  bucket_name = "${local.project}-${local.environment}-data"
}

resource "aws_s3_bucket" "example" {
  bucket = local.bucket_name
}
👉 bucket_name is computed using project + environment → ecommerce-prod-data.



2️⃣ Using Terraform Functions
You can use built-in functions (like lower(), upper(), replace(), format(), etc.).
locals {
  environment = "Prod"
  bucket_name = lower("MyApp-${local.environment}-Bucket")
}
👉 bucket_name will be computed as myapp-prod-bucket.

```

another example of local block:
```hcl
locals {
  bucket_prefix = "tf-${var.environment}"
  bucket_name   = "${local.bucket_prefix}-app-data"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = local.bucket_name
}

```
Here:
- ```bucket_prefix``` is calculated once.
- ```bucket_name``` uses ```ucket_prefix```.

### 🔹 Difference: Variable vs Local

- **```Variable```** → input values (provided by user via ```terraform.tfvars``` or -```var```).
- **```Local```** → internal values (calculated or constant inside the code).

Think like this:
- **```variable = input from outside world 🌍```**
- **```local = helper inside Terraform code 🛠️```**

### Use locals when you need to:

- **Compute values based on variables or resources**
- Avoid repeating complex expressions
- **Create intermediate values for readability**
- Process and transform data
- Define reusable configuration blocks

✅ In short:
Terraform locals are like helper variables to simplify code, remove repetition, and keep things consistent.

```hcl
locals {
  project-01-tags = {
    Name = "${var.project}-${var.Environment}"
    Ownere = "Satheesh"
    Managed_By = "Terraform"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = local.project-01-tags
}


resource "aws_instance" "test-01" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t2.micro"
    tags = local.project-01-tags
}


resource "aws_ebs_volume" "tst-01" {
    availability_zone = "us-east-1a"
    size = 5
    tags = local.project-01-tags
}

variable "Environment" {
  type = string
  default = "prod"
}

variable "project" {
    type = string
    default = "AMAZON"
}

```
<img width="484" height="463" alt="image" src="https://github.com/user-attachments/assets/aee6abd2-a6bf-4058-9491-54e1b8d13520" />

