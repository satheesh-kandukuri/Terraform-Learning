### 🌱 Meta-Arguments in Terraform:

👉 ```Meta-arguments``` are special arguments you can **add to resources/modules** in Terraform.
They don’t belong to the resource itself — instead, ```they change how Terraform manages that resource```

Think of them as Terraform’s special instructions 📝 to control when, how many, or if a resource should be created. 
These are ```universal settings you can add to any resource block```

📌 Terraform Meta-Arguments List

- ```count``` – create multiple copies of a resource by number.
- ```for_each``` – create multiple resources from a map or set.
- ```provider``` – choose which provider configuration to use.
- ```depends_on``` – manually define dependencies.
- ```lifecycle``` – control special resource lifecycle behavior.
- ```inside lifecycle``` we have: we considered these as sub-arguments
  - prevent_destroy
  - ignore_changes
  - create_before_destroy
  - replace_triggered_by


🧠 Memory Trick:

- ```count``` → “How many?”
- ```for_each``` → “For every item”
- ```provider``` → “Which provider config”
- ```depends_on``` → “Wait for this first”
- ```lifecycle``` → “Special rules”
- ```prevent_destroy``` → Don’t delete
- ```ignore_changes``` → Ignore updates
- ```create_before_destroy``` → Replace safely
- ```replace_triggered_by``` → Recreate if linked resource changes


Provisioners are another type of meta arguments in Terraform! They let you run scripts or commands on resources after they're created.
Think of provisioners as: "After you create this resource, also do this extra thing"
1. file
2. local-exec
3. remote-exec


Conditional statements:
1. if else 
2. ternary operators

**```String interpolation```** with ```${}``` lets you embed expressions inside strings - it's like inserting variables or calculations into text.
string interpolation is one of Terraform's most powerful features for building dynamic, flexible infrastructure configurations.
 ### Basic Usage:
```hcl
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "example" {
  bucket = "my-app-bucket-${random_string.bucket_suffix.result}"
  # Result: "my-app-bucket-a1b2c3d4"
}
```
 ### Configuration Options:
 ```hcl
 resource "random_string" "example" {
  length  = 16                # Length of the string
  upper   = true             # Include uppercase letters (A-Z)
  lower   = true             # Include lowercase letters (a-z)  
  numeric = true             # Include numbers (0-9)
  special = true             # Include special characters (!@#$...)
  
  # Optional: customize special characters
  override_special = "!@#$%"  # Only use these special chars
  
  # Optional: exclude certain characters
  min_upper   = 2            # At least 2 uppercase
  min_lower   = 2            # At least 2 lowercase  
  min_numeric = 2            # At least 2 numbers
  min_special = 1            # At least 1 special char
}
```
 ### Function Calls:
 ```hcl
resource "aws_s3_bucket" "logs" {
  bucket = "${lower(var.company_name)}-logs-${formatdate("YYYY-MM", timestamp())}"
  # Result: "acmecorp-logs-2024-01"
}

resource "aws_instance" "web" {
  tags = {
    Name        = "${upper(var.environment)}-WebServer"
    CreatedDate = "${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}"
    # Results: "PROD-WebServer", "15 Jan 2024 14:30 UTC"
  }
}
```
### Example:
```hcl
resource "random_string" "rndm" {
  length           = 5
#  upper            = true
  lower            = true
}


variable "company_name" {
  type    = string
  default = "shaam-associates"
}


resource "aws_instance" "test-01" {
  ami           = "ami-0de716d6197524dd9"
  instance_type = "t2.micro"
  count         = 2

  tags = {
    Name = "${lower(var.company_name)}-${random_string.rndm.result}-${formatdate("YYYY-MM", timestamp())}"
  }
}

resource "aws_instance" "test-02" {
  ami           = "ami-0de716d6197524dd9"
  instance_type = "t2.micro"
  count         = 2

  tags = {
    Name = "${lower(var.company_name)}-${random_string.rndm.result}-${formatdate("YYYY-MM", timestamp())}"
  }
}

```
<img width="973" height="204" alt="image" src="https://github.com/user-attachments/assets/c099c800-9ec1-4cbf-aafb-378f2fa53883" />

