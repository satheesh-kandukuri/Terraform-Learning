variable "elb_name" {
    type = string
}

variable "availability_zones" {
    type = list(string)
    description = "List of availability zones for the AWS Classic Load Balancer"
    validation {
      condition = length(var.availability_zones) > 1
      error_message = "At least 2 availability zones must be specified."
    }
}

variable "listener" {
    description = "Listener rules"
    type = object({
      instance_port = number
      instance_protocol = string
      lb_port = number
      lb_protocol = string
    })
}

variable "health_check" {
    description = "Health check settings"
    type = object({
      healthy_threshold = number
      unhealthy_threshold = number
      timeout = number
      target = string
      interval = number
    })
}
 

variable "ami_ids" {
    description = "List of AMI IDs for the EC2 instances"
    type = list(string)
    validation {
      condition = length(var.ami_ids) > 1
      error_message = "At least 2 AMI IDs must be specified."
    }
}


variable "cross_zone_load_balancing" {
    description = "Enable cross-zone load balancing"
    type = bool
}
variable "idle_timeout" {
    description = "Idle timeout for the load balancer"
    type = number
}

variable "connection_draining" {
    description = "Enable connection draining"
    type = bool
}


variable "connection_draining_timeout" {
    description = "Connection draining timeout in seconds"
    type = number
}

variable "tags" {
    description = "Tags to assign to the load balancer"
    type = map(string)
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t1.micro"
}


variable "prd_ec2_instance_tags" {
    description = "tags to assign to the PROD EC2 instances"
    type = map(string)
    default = {
        Environment = "PRD"
    }
}


variable "stg_ec2_instance_tags" {
    description = "tags to assign to the STG EC2 instances"
    type = map(string)
    default = {
        Environment = "STG"
    }
}
