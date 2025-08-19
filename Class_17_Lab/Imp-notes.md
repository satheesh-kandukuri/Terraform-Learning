In realtime projects below meta arguments are heavily used:
1. ```for_each```
2. ```count```

Don't use ```for_each``` and ```count``` together in the same resource block

How ```for_each``` works?
under ```for_each``` argument, you can only use map or set or toset variable type,
list is not supported using for_each.

```count```, is works with list variable type.

 
 ### What is for_each?

- ```for_each``` is a Terraform meta-argument you can use inside a resource or module.
- It lets you create multiple resources at once based on a map or a set of strings.
- Each resource gets its own unique key (each.key) and value (each.value).

🔹 Example with a Map:
```hcl
variable "instances" {
  default = {
    dev   = "t2.micro"
    stage = "t2.small"
    prod  = "t2.medium"
  }
}

resource "aws_instance" "example" {
  for_each = var.instances

  ami           = "ami-123456"
  instance_type = each.value
  tags = {
    Name = each.key
  }
}
```
👉 Terraform will create 3 EC2 instances:

- Key = ```dev``` → Value = ```t2.micro```
- Key = ```stage``` → Value = ```t2.small```
- Key = ```prod``` → Value = ```t2.medium```

So:
- each.key → ```dev```, ```stage```, ```prod```
- each.value → ```t2.micro```, ```t2.small```, ```t2.medium```


Why ```for_each``` is Awesome?

- Readable: You know which resource is which (dev, stage, prod) instead of just count.index = 0,1,2.
- Flexible: Easy to map names → values.
- Safe: If you remove one key from the map, only that resource gets destroyed, not others (with count, the **indexes shift and can destroy/recreate unintended resources**).

If you remove ```stage``` from the map, Terraform only destroys ```stage``` and leaves ```dev``` + ```prod``` untouched.

✅ In short:
- Use ```count``` when you just need **N copies**.
- Use ```for_each``` when you need resources tied to specific **keys/values** (like environments, regions, etc.) with **meaningful** names/keys.

Example:
```hcl
resource "aws_iam_user" "dbusers" {
  name  = var.iam_users[count.index]
  count = length(var.iam_users)
}


resource "aws_iam_user" "dbusers" {
    for_each = var.iam_users
    name     = each.value
}


variable "iam_users" {
  type        = set(string)
  default     = ["OG", "Shaam", "Jai"]
  description = "List of IAM users"
}
```
<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/ea024566-72df-4f0a-b19d-5a90b2c91ff1" />


### Conditional statements in Terraform

#### ternary operator
The ```ternary operator``` in Terraform, also known as a conditional expression, provides a way to select one of two values based on a boolean condition.
The syntax looks like this:
```hcl
condition ? true_value : false_value

```
- ```condition```:
This is a boolean expression that evaluates to either ```true``` or ```false```. It can involve comparisons (e.g., ==, !=, <, >), logical operators (e.g., &&, ||), or functions that return a boolean.
- ```true_value```:
This is the value that will be returned if the condition evaluates to true. 
- ```false_value```:
This is the value that will be returned if the condition evaluates to false

Example:

```hcl
resource "aws_instance" "dbaas" {
  ami           = var.input == "Prod" ? var.ami[0] : var.input == "Test" ? var.ami[1] : var.ami[2]
  instance_type = var.instance_type[var.input]
  tags = {
    Name        = "DBaaS-${var.input}"
    Environment = var.input
  }
}

variable "ami" {
  description = "AMI ID for the AWS instance"
  type        = list(string)
  default     = ["ami-0ec18f6103c5e0491", "ami-020cba7c55df1f615", "ami-00ca32bbc84273381"]
}

variable "instance_type" {
  description = "Instance type for the AWS instance"
  type        = map(string)
  default = {
    "Prod" = "t3.medium"
    "Test" = "t3.small"
    "Dev"  = "t3.nano"
  }
}

variable "input" {
  description = "Select the environment to deploy"
  type        = string
}
```

<img width="400" height="100" alt="image" src="https://github.com/user-attachments/assets/49a79cf9-aa7f-4998-b00a-2225a6e3fe63" />

<img width="700" height="450" alt="image" src="https://github.com/user-attachments/assets/3623c8b6-0c5b-406a-a1c4-2241c00080da" />
