### 🔹 What is ```depends_on```?

In Terraform, ```depends_on``` is a meta-argument used to force an explicit dependency between resources.

Normally, Terraform automatically understands dependencies from references (like when one resource uses another’s attribute).
But sometimes, **implicit dependency is not enough**, and **```we must explicitly tell Terraform```**

**👉 “Hey, don’t create this resource until that one is ready.”**

### 🔹 Why do we use it? (Importance)

- **Control order of resource creation** – ensure one resource is created/destroyed before another.
- **Avoid race conditions** – sometimes, even if resources don’t directly reference each other, you still want Terraform to respect order.
- **Ensure correctness** – some services need setup in a specific sequence.

### 🔹 Key Points to Remember

Terraform auto-detects dependencies when one resource references another.
- Use depends_on when:
  - No direct reference exists.
  - You need to enforce a specific order.
  - You want to avoid race conditions.
- It accepts a list of resources.

**```https://developer.hashicorp.com/terraform/language/resources/behavior```**

Example: 
```hcl
resource "aws_instance" "test-01" {
  ami  = "ami-00ca32bbc84273381"
  instance_type = "t2.nano"
  depends_on = [ aws_s3_bucket.tst-bkt-01 ]
}


resource "aws_s3_bucket" "tst-bkt-01" {
  bucket = "test-bucket-007"
}
```
