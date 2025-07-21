# AWS VPC and Security Group Terraform Configuration

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)

This Terraform project creates multiple VPCs with associated security groups in AWS. The configuration demonstrates Infrastructure as Code (IaC) principles using:
- Variable management
- Resource tagging
- Security group configuration
- Multi-VPC architecture

## Resources Created

### VPCs
- Creates two VPCs in the ca-central-1 region:
  - Main VPC with CIDR block from variables
  - Second VPC with different CIDR block
  - Both VPCs have DNS hostnames and DNS support enabled
  - Custom tags applied using the merge function

### Security Group
- Creates a security group in the main VPC
- Configures SSH access (inbound rules)
- Allows all outbound traffic

## Prerequisites
- AWS CLI configured
- Terraform installed
- Appropriate AWS permissions

## Variables

### Required Variables
- `aws_region`: AWS region for resource deployment
- `cidr_block`: CIDR block for the main VPC
- `second_vpc_cidr`: CIDR block for the second VPC
- `aws_security_group`: Name for the security group
- `SSH_Port`: Port number for SSH access
- `All_Outbound_Ports`: Protocol for outbound traffic
- `Allow_All`: CIDR for outbound traffic (typically 0.0.0.0/0)

### Optional Variables
- `enable_dns_hostnames`: Enable DNS hostnames in VPCs (default: true)
- `enable_dns_support`: Enable DNS support in VPCs (default: true)
- `vpc_name`: Name tag for VPCs
- `tags`: Map of tags to apply to resources

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/satheesh-kandukuri/Terraform-Learning.git
   cd Terraform-Learning
   ```

2. Update `terraform.tfvars` with your desired values:
   ```hcl
   aws_region           = "ca-central-1"
   cidr_block          = "10.0.0.0/16"
   second_vpc_cidr     = "172.16.0.0/16"
   aws_security_group  = "terraform-sg"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## File Structure
```
.
├── main.tf           # Main configuration file
├── variables.tf      # Variable declarations
├── terraform.tfvars  # Variable values
├── provider.tf       # Provider configuration
└── README.md        # This file
```

## Security Group Rules

### Inbound Rules
- Allows SSH access (TCP port from variables) from within the VPC CIDR range

### Outbound Rules
- Allows all outbound traffic to any destination (0.0.0.0/0)

## Tags
The VPCs are tagged with:
- Environment
- Project name
- Owner information
- Designation
- Custom name combining vpc_name variable with "First VPC" or "Second VPC"

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/AmazingFeature`
3. Commit your changes: `git commit -m 'Add some AmazingFeature'`
4. Push to the branch: `git push origin feature/AmazingFeature`
5. Open a Pull Request

## Maintainer
👤 **Satheesh**
- Role: DevOps Engineer
- GitHub: [@satheesh-kandukuri](https://github.com/satheesh-kandukuri)

## Important Notes

### Security Considerations
- Security group is configured for SSH access only
- Outbound traffic is allowed to all destinations
- Consider restricting CIDR ranges based on your requirements

### Cleanup
Remember to destroy resources when they're no longer needed:
```bash
terraform destroy
```

