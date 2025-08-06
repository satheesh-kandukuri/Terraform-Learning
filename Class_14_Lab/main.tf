resource "aws_instance" "VM-01" {
  ami           = var.ami_id
  instance_type = var.instance_type
}


# variable "ami_id" {
#   description = "The AMI ID to use for the instance"
#   type        = string
#   default     = "ami-08a6efd148b1f7504"  
#   validation {
#     condition     = length(var.ami_id) > 0 && substr(var.ami_id,0,4) == "ami-"
#     error_message = "AMI ID must be a valid AMI, starting with 'ami-' and not be empty."
#   }
# }

# variable "instance_type" {
#   description = "The type of instance to create"
#   type        = string
#    validation {
#     condition     = can(regex("^[Tt][2-3].(micro|small|medium)", var.instance_type))
#     error_message = "Invalid instance type. Must be t2.micro, t2.small, t2.medium, t3.micro, t3.small, or t3.medium."
#    }
# }

# condition = length(var.ami_id) > 0 && substr(var.ami_id, 0, 4) == "ami-"
# Here's what each part means:
# - `length(var.ami_id) > 0`: Ensures that the AMI ID is not an empty string.
# - `substr(var.ami_id, 0, 4)`: Extracts the first 4 characters of the ami_id string.
# - `== "ami-"`: Checks if those first 4 characters are "ami-". which is the standard prefix for AWS AMI IDs.
# && is a logical AND operator, meaning both conditions must be true for the validation to pass.
# If both conditions are true, the AMI ID is considered valid.


# substr(var.ami_id, 0, 4), You're using the built-in Terraform function substr() — which extracts a substring from a given string.
# substr(string, offset, length) 
# string: The original string to extract from (e.g., var.ami_id)
# offset: The starting position (0-based index) to begin extracting characters
# length: The number of characters to extract
# substr(var.ami_id, 0, 4), original string is var.ami_id, which is "ami-08a6efd148b1f7504"
# 0 → start from index 0 (the first character: 'a')
# 4 → take 4 characters
# ✅ Result: "ami-"



/*
The “scripts” are simple human-readable text files that describe the desired deployment architecture. Each resource to be deployed will have a section, and each includes the configuration parameters needed to instantiate the resource. The deployment architecture can be split over many script files - all held in a single directory. Any Terraform command always runs in the context of your current directory - often called the Terraform ‘’root’. Remember that any Terraform will ignore any scripts not in the current directory - including subdirectories. You can name your scripts anything you like as long as they have a “.tf” suffix. Even main.tf is not mandatory, although a strong convention.
*/

# terraform.tfvars:
# Terraform allows you to define variable files called ```*.tfvars``` to create a reusable file for all the variables for a project.
