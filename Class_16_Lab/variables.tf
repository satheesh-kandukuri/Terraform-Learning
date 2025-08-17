variable "ami_ids" {
  type = map(string)
}


variable "database_ec2_instance_config" {
  type = object({
    availability_zone = string
    instance_type     = string
    key_name          = string
    root_block_device = object({
      volume_size           = number
      volume_type           = string
      encrypted             = bool
      delete_on_termination = bool
      iops                  = number
    }) 
  })
}
 
variable "database_ec2_tags" {
  type = object({
    Name        = string
    Environment = string
    Department  = string
  })
}
 

variable "az" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

variable "amiid" {
  type = map(string)
  default = {
    "prd" = "ami-0de716d6197524dd9"
    "dev" = "ami-0ec18f6103c5e0491"
  }
}


variable "intype" {
  type = map(string)
  default = {
    "prd" = "t3.medium"
    "dev" = "t3.micro"
  }
}
