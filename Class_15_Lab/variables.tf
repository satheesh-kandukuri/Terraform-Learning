variable "ami" {
  type        = string
  default     = "ami-084a7d336e816906b"
  description = "The AMI ID to use for the instance"
}


variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "tag" {
  type    = string
  default = "PRD-07"
}