variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the main VPC"
  type        = string
}

variable "second_vpc_cidr" {
  description = "The CIDR block for the second VPC"
  type        = string
}

variable "Allow_All" {
  description = "The CIDR block for the main VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}
variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the VPC"
  type        = map(string)
  default = {
    "name"        = "Terraform - VPC"
    "environment" = "development"
    "project"     = "Terraform Practice Lab"
    "owner"       = "Satheesh"
    "Designation" = "AI Engineer"
  }

}

variable "aws_security_group" {
  description = "Enable SSH/All Outbound"
  type        = string
}

variable "SSH_Port" {
  description = "This is used for SSH Access"
  type        = number
}

variable "All_Outbound_Ports" {
  description = "equivalent to all ports"
  type        = string
}