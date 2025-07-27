# Terraform Practice Lab - Class 11

This project demonstrates the use of Terraform to create and manage AWS resources. The configuration includes creating an EBS volume, taking a snapshot, creating an AMI from the snapshot, 
copying the AMI to same region and another region, and launching an EC2 instance with user data.

## Files in the Project

- **`main.tf`**: Contains the Terraform configuration for creating and managing AWS resources.
- **`provider.tf`**: Configures the AWS providers for the source and destination regions.
- **`variables.tf`**: Declares variables used in the Terraform configuration.


## Resources Created

### 1. EBS Volume
- **Resource**: `aws_ebs_volume` 
- **Purpose**: Creates an EBS volume in the specified availability zone.
- **Key Attributes**:
  - `availability_zone`: The availability zone where the volume is created.
  - `size`: The size of the volume in GiB.
  - `type`: The type of the volume (e.g., `gp3`).
  - `tags`: Tags assigned to the volume.

### 2. EBS Snapshot
- **Resource**: `aws_ebs_snapshot`
- **Purpose**: Creates a snapshot of the EBS volume.
- **Key Attributes**:
  - `volume_id`: The ID of the EBS volume to snapshot.
  - `tags`: Tags assigned to the snapshot.

### 3. AMI Creation
- **Resource**: `aws_ami`
- **Purpose**: Creates an AMI from the EBS volume snapshot.
- **Key Attributes**:
  - `name`: Name of the AMI.
  - `virtualization_type`: Virtualization type (e.g., `hvm`).
  - `root_device_name`: Root device name.
  - `imds_support`: IMDS version support.
  - `ebs_block_device`: Configuration for the EBS block device, including the snapshot ID and volume size.

### 4. AMI Copy
- **Resource**: `aws_ami_copy`
- **Purpose**: Copies the AMI to a different region.
- **Key Attributes**:
  - `name`: Name of the copied AMI.
  - `source_ami_id`: ID of the source AMI.
  - `source_ami_region`: Region of the source AMI.
  - `tags`: Tags assigned to the copied AMI.
  - `provider`: Specifies the destination AWS provider.

### 5. EC2 Instance
- **Resource**: `aws_instance`
- **Purpose**: Launches an EC2 instance using the created AMI.
- **Key Attributes**:
  - `ami`: ID of the AMI to use for the instance.
  - `instance_type`: Type of the instance (e.g., `t2.micro`).
  - `key_name`: Name of the key pair for SSH access.
  - `user_data`: Path to the user data script.
  - `tags`: Tags assigned to the instance.

## Variables

### Declared in `variables.tf`
- `availability_zone`: The availability zone for the EBS volume.
- `size`: The size of the EBS volume in GiB.
- `type`: The type of the EBS volume.
- `tags`: A map of tags to assign to resources.
- `user_data`: Path to the user data script.
- `source_ami_region`: Region of the source AMI.

### Defined in `terraform.tfvars`
- `availability_zone`: `us-east-1a`
- `size`: `1`
- `type`: `gp3`

## Providers

### Declared in `provider.tf`
- **Source Region**:
  - Alias: `source`
  - Region: `us-east-1`
- **Destination Region**:
  - Alias: `destination`
  - Region: `us-west-2`

## Steps to Execute

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Validate the Configuration**:
   ```bash
   terraform validate
   ```

3. **Plan the Changes**:
   ```bash
   terraform plan
   ```

4. **Apply the Changes**:
   ```bash
   terraform apply
   ```

5. **Verify the Resources**:
   - Check the AWS Management Console to verify the created resources.

## Notes
- Ensure the snapshot ID (`snap-072ed1789d6546138`) exists in the `us-east-1` region.
- Update the `key_name` in the EC2 instance resource to match your key pair.
- The `user_data` variable should point to a valid script file.

## Cleanup
To destroy the created resources, run:
```bash
terraform destroy
```
