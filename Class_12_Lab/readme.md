# Terraform Practice Lab - Class 12

This repository contains Terraform configurations for setting up AWS resources as part of a practice lab. The configurations demonstrate the use of IAM roles, instance profiles, and EC2 instances.

## Resources Created

### IAM Role
- **Name**: `TF_role`
- **Purpose**: Allows EC2 instances to assume the role and access AWS services.
- **Assume Role Policy**: Grants EC2 service the ability to assume the role.

### IAM Role Policy Attachment
- **Policy ARN**: `arn:aws:iam::aws:policy/AmazonS3FullAccess`
- **Purpose**: Grants full access to Amazon S3 for the IAM role.

### IAM Instance Profile
- **Name**: `test_profile`
- **Purpose**: Associates the IAM role with EC2 instances.

### EC2 Instance
- **Name**: `test-vm-01`
- **AMI**: `ami-054b7fc3c333ac6d2`
- **Instance Type**: `t2.micro`
- **IAM Instance Profile**: `test_profile`
- **Tags**: `{ Name = "test-vm-01" }`

## Prerequisites

- Terraform installed on your local machine.
- AWS CLI configured with appropriate credentials and permissions.
- An AWS account.

## Usage

1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd Class-12_Lab
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the execution plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration to create resources:
   ```bash
   terraform apply
   ```

6. To destroy the resources:
   ```bash
   terraform destroy
   ```

## Code Explanation

### `aws_iam_role` Resource
This resource creates an IAM role named `TF_role`. The `assume_role_policy` defines a trust relationship, allowing EC2 instances to assume this role. The policy specifies that the EC2 service (`ec2.amazonaws.com`) is allowed to assume the role.

### `aws_iam_role_policy_attachment` Resource
This resource attaches the `AmazonS3FullAccess` policy to the `TF_role`. This grants the role full access to Amazon S3, enabling EC2 instances using this role to interact with S3 resources.

### `aws_iam_instance_profile` Resource
This resource creates an instance profile named `test_profile` and associates it with the `TF_role`. Instance profiles are used to pass IAM roles to EC2 instances.

### `aws_instance` Resource
This resource launches an EC2 instance named `test-vm-01` with the following specifications:
- **AMI**: `ami-054b7fc3c333ac6d2` (ensure this is valid in your AWS region).
- **Instance Type**: `t2.micro` (a cost-effective instance type for testing).
- **IAM Instance Profile**: `test_profile` (provides the instance with the permissions defined in the IAM role).
- **Tags**: Adds a `Name` tag with the value `test-vm-01` for easy identification in the AWS Management Console.

## Notes

- The `assume_role_policy` is required to define the trust relationship for the IAM role.
- The `AmazonS3FullAccess` policy is attached to the IAM role to grant S3 access.
- Ensure the AMI ID (`ami-054b7fc3c333ac6d2`) is valid in your AWS region.


