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
