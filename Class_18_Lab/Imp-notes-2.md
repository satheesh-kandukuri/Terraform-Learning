### Difference between Argument Reference and Attribute Reference in Terraform


# 🔹 Argument Reference

- Definition → Inputs you configure inside a resource or module.
- You set these values.

Example:
```hcl
resource "aws_instance" "example" {
  ami           = "ami-123456"   # argument
  instance_type = "t3.micro"     # argument
}
```
👉 Here, ami and instance_type are arguments.


# 🔹 Attribute Reference

Definition → Outputs that Terraform provides after creating a resource.
You read these values (can use them elsewhere).

Example:
```hcl
output "instance_ip" {
  value = aws_instance.example.public_ip   # attribute
}
```
👉 Here, public_ip is an attribute exposed by AWS after the instance is created.

✅ In short:

- ```Arguments = What you give to Terraform (inputs).```
- ```Attributes = What Terraform gives back after creating resources (outputs).```

example:
```hcl

resource "aws_s3_bucket" "tst-001" {
  bucket = "tst-001-bkt"
}

output "bucket-info" {
  value     = aws_s3_bucket.tst-001
  sensitive = false
}
```

# 🔹Output blocks
when executing terraform apply and its creating the resources, but we don't see the much information about the resources getting created. How do we see that information?
- If we have console access, we can use the AWS Management Console to view the resources that have been created and thei attributes as well.
- **If we don't have console access?**
  we have to use ```output blocks``` to extract information about the created resources.
  We can define output variables in our Terraform configuration (```outputs.tf```) to capture and display this information.
  ```terraform output --json```

```terraform show``` command. This command displays the current state of your Terraform-managed infrastructure in a human-readable format.
 
 ```json

PS C:\Users\k\temppath\MyLearning\Terraform\Practice_Lab\Class-18_Lab> terraform show
# aws_s3_bucket.tst-001:
resource "aws_s3_bucket" "tst-001" {
    acceleration_status         = null
    arn                         = "arn:aws:s3:::tst-001-bkt"
    bucket                      = "tst-001-bkt"
    bucket_domain_name          = "tst-001-bkt.s3.amazonaws.com"
    bucket_prefix               = null
    bucket_region               = "us-east-1"
    bucket_regional_domain_name = "tst-001-bkt.s3.us-east-1.amazonaws.com"
    force_destroy               = false
    hosted_zone_id              = "Z3AQBSTGFYJSTF"
    id                          = "tst-001-bkt"
    object_lock_enabled         = false
    policy                      = null
    region                      = "us-east-1"
    request_payer               = "BucketOwner"
    tags_all                    = {}

    grant {
        id          = "058354d4e9556c68da7cf0eca68dd24b95a96ce64194baf3350048cbe14605e3"
        permissions = [
            "FULL_CONTROL",
        ]
        type        = "CanonicalUser"
        uri         = null
    }

    server_side_encryption_configuration {
        rule {
            bucket_key_enabled = false

            apply_server_side_encryption_by_default {
                kms_master_key_id = null
                sse_algorithm     = "AES256"
            }
        }
    }

    versioning {
        enabled    = false
        mfa_delete = false
    }
}


Outputs:

bucket-info = {
    acceleration_status                  = null
    arn                                  = "arn:aws:s3:::tst-001-bkt"
    bucket                               = "tst-001-bkt"
    bucket_domain_name                   = "tst-001-bkt.s3.amazonaws.com"
    bucket_prefix                        = null
    bucket_region                        = "us-east-1"
    bucket_regional_domain_name          = "tst-001-bkt.s3.us-east-1.amazonaws.com"
    cors_rule                            = []
    force_destroy                        = false
    grant                                = [
        {
            id          = "058354d4e9556c68da7cf0eca68dd24b95a96ce64194baf3350048cbe14605e3"
            permissions = [
                "FULL_CONTROL",
            ]
            type        = "CanonicalUser"
            uri         = null
        },
    ]
    hosted_zone_id                       = "Z3AQBSTGFYJSTF"
    id                                   = "tst-001-bkt"
    lifecycle_rule                       = []
    logging                              = []
    object_lock_configuration            = []
    object_lock_enabled                  = false
    policy                               = null
    region                               = "us-east-1"
    replication_configuration            = []
    request_payer                        = "BucketOwner"
    server_side_encryption_configuration = [
        {
            rule = [
                {
                    apply_server_side_encryption_by_default = [
                        {
                            kms_master_key_id = null
                            sse_algorithm     = "AES256"
                        },
                    ]
                    bucket_key_enabled                      = false
                },
            ]
        },
    ]
    tags_all                             = {}
    versioning                           = [
        {
            enabled    = false
            mfa_delete = false
        },
    ]
    website                              = []
}

