database_ec2_instance_config = {
    availability_zone = "us-east-1a"
    instance_type     = "t3.medium"
    key_name          = "PractiseKeyPair"
  root_block_device = {
    volume_size           = 10
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = false
    iops                  = 1000
  }
}


ami_ids = {
    database-host = "ami-0de716d6197524dd9"
    unix-host     = "ami-020cba7c55df1f615"
    storage-host  = "ami-0ec18f6103c5e0491"
}


database_ec2_tags = {
  Department = "database-dpt"
  Name        = "database-instance"
  Environment = "production"
}

