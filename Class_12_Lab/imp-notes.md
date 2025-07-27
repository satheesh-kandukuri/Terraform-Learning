What if i don't give **assume_role_policy** while creating iam role, 
any way for iam role i'm attaching policies and attaching that to ec2 using instance_profile right ?
then what is the necessary of **assume_role_policy**?

```hcl
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.TF_role.name
}
```
### 🔍 Short Answer:

If you don’t provide an assume_role_policy, the IAM role won’t be usable by EC2 or any other AWS service, even if you attach all the policies in the world.

### ✅ Why assume_role_policy is Required

When you create an IAM role, AWS must know what service or principal is allowed to assume (use) the role.

    This is handled through the assume_role_policy (a trust relationship).

    It’s not about what the role can do, but who can use the role.

### 🧱 IAM Role Has Two Parts:
<img width="1025" height="315" alt="image" src="https://github.com/user-attachments/assets/1744b85c-7f54-40aa-b731-7debdb862e1f" />


### 🧨 What Happens if You Omit assume_role_policy

    Terraform will throw an error like:

         Error creating IAM Role: MalformedPolicyDocument: The trust relationship policy document must specify a principal 

    Even if it allows the role to be created, EC2 will not be allowed to use the role, and your instance won’t inherit the permissions.

### ✅ Example of a Valid Trust Policy for EC2    
``` hcl
assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }
  ]
})
```

This tells AWS:

    “I trust the EC2 service to use this role.”

### 🧠 Analogy:

    Think of the assume_role_policy as the "Who can borrow the key?" part.

    And the permissions policy as "What can the key do once borrowed?"   
    
<img width="852" height="234" alt="image" src="https://github.com/user-attachments/assets/9c155fa1-8221-487a-854c-0454364bb6a1" />


                ┌────────────────────┐
                │    IAM Role        │
                │--------------------│
                │ 🎯 Permissions:    │
                │   - S3 Full Access │
                │   - EC2 Trust      │
                └────────▲───────────┘
                         │
                         │ Assigned to
                         ▼
            ┌────────────────────────────┐
            │     Instance Profile       │
            │----------------------------│
            │ Wraps exactly 1 IAM Role   │
            └────────▲───────────────────┘
                     │
         Attached to │
                     ▼
          ┌──────────────────────┐
          │      EC2 Instance    │
          │----------------------│
          │ Uses Instance Profile│
          └────────▲─────────────┘
                   │
        EC2 metadata service (IMDS)
        http://169.254.169.254
                   │
                   ▼
  Temporary credentials are provided to the EC2
      (automatically rotated by AWS)

### 🔁 What Happens at Runtime:

    You launch EC2 and attach the Instance Profile.

    EC2 talks to the Instance Metadata Service at http://169.254.169.254.

    It requests temporary security credentials tied to the IAM role inside the profile.

    AWS returns temporary access keys + tokens with permissions defined in the role.

    Your application or CLI inside the EC2 can now run aws s3 ls, aws s3 cp, etc. — without any credentials configured manually.

<img width="914" height="312" alt="image" src="https://github.com/user-attachments/assets/5a6a592c-f8f4-422a-b904-0a56b64aee16" />
    
