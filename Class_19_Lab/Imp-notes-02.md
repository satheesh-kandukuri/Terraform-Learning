## 🔹 What is Lifecycle in Terraform?

The ```lifecycle``` block in Terraform is used inside a resource to control how Terraform manages create, update, and delete actions.
It doesn’t change the resource itself, but **influences Terraform’s behavior**.
```hcl
resource "aws_instance" "test-01" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [tags]
  }
}
```

### 🔹 Lifecycle Arguments
1. ```create_before_destroy```

- Ensures a new resource is created first before the old one is destroyed.
- Prevents downtime.
```hcl
lifecycle {
  create_before_destroy = true
}
```
👉 Useful for resources like Load Balancers, DNS records, or servers where downtime must be avoided.

2. ```prevent_destroy```

- Stops Terraform from accidentally destroying a resource.
- If ```terraform destroy``` or a config change tries to delete it, Terraform will throw an error.
```hcl
lifecycle {
  prevent_destroy = true
}
```
### 3. ignore_changes
- Tells Terraform to **ignore specific attribute changes** outside of Terraform.

### 🔹 Why Lifecycle is Important?

- Prevent downtime → with ```create_before_destroy```.
- Protect critical infra → with ```prevent_destroy```.
- Avoid unnecessary updates → with ```ignore_changes```.
- Fine-grained control → lets you override Terraform’s default ```destroy and recreate``` behavior.

✅ In short:
The lifecycle block in Terraform is like a **safety and behavior control tool** — 
it helps you protect, preserve, or customize how Terraform creates, updates, and deletes resources.

<img width="789" height="189" alt="image" src="https://github.com/user-attachments/assets/c55689d0-2e90-4311-bbd6-9c99b2e08a53" />

<img width="789" height="189" alt="image" src="https://github.com/user-attachments/assets/1dbb9f1e-fb9a-40cc-9c10-871b32ff0264" />
