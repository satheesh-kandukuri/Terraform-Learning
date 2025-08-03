### **In this exercise i learned how to create AWS VPC, Subnets, Create Public Subnets, InternetGway, How to associate route table, launch instances with those public subnets.**

## Public and Private Subnets

### `map_public_ip_on_launch` Attribute:

- "map_public_ip_on_launch" attribute is a critical setting for defining the networking behavior of subnets in an AWS VPC. By setting it to true, you enable automatic public IP assignment for instances in public subnets, facilitating internet access.
- Setting it to false supports private subnets, enhancing security for internal resources.

- setting "map_public_ip_on_launch = true" in the aws_subnet resource is a key requirement to making a subnet a public subnet in AWS

- For a subnet to be fully functional as a public subnet, it must also be associated with a route table that has a route to an Internet Gateway (e.g., 0.0.0.0/0 → igw-xxxxxxxx).

- Internet Gateway Routing: The subnet must be associated with a route table that includes a route to an Internet Gateway for the destination 0.0.0.0/0 (all IPv4 traffic). This allows instances to send and receive traffic to/from the internet.

- **Public Subnets**: Setting `map_public_ip_on_launch = true` enables automatic public IP assignment for instances in public subnets, facilitating internet access.
- **Private Subnets**: Setting `map_public_ip_on_launch = false` supports private subnets, enhancing security for internal resources.

### Requirements for a Public Subnet
For a subnet to function as a public subnet, the following conditions must be met:
1. **Public IP Assignment**: The `map_public_ip_on_launch` attribute must be set to `true` in the `aws_subnet` resource.
2. **Route Table Association**: The subnet must be associated with a route table that includes a route to an Internet Gateway (e.g., `0.0.0.0/0 → igw-xxxxxxxx`).

### Internet Gateway Routing
- The route table associated with the subnet must include a route to an Internet Gateway for the destination `0.0.0.0/0` (all IPv4 traffic).
- This configuration allows instances in the subnet to send and receive traffic to/from the internet.

---

## Terraform Variables

### Types of Variables
1. **Input Variables**: Used to customize Terraform configurations. They allow users to pass values into modules.
2. **Output Variables**: Display information about the resources created or modified by Terraform. They are useful for:
   - Sharing data between modules.
   - Providing results to users.
   - Passing values to other tools.


