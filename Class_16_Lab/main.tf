resource "aws_instance" "database" {
  ami               = var.ami_ids.database-host
  availability_zone = var.database_ec2_instance_config.availability_zone
  instance_type     = var.database_ec2_instance_config.instance_type
  key_name          = var.database_ec2_instance_config.key_name
  root_block_device {
    volume_size           = var.database_ec2_instance_config.root_block_device.volume_size
    volume_type           = var.database_ec2_instance_config.root_block_device.volume_type
    encrypted             = var.database_ec2_instance_config.root_block_device.encrypted
    delete_on_termination = var.database_ec2_instance_config.root_block_device.delete_on_termination
    iops                  = var.database_ec2_instance_config.root_block_device.iops
  }
  tags = var.database_ec2_tags
}


resource "aws_instance" "vm-01" {
    ami = var.amiid["prd"]
    instance_type = var.intype["prd"]
    availability_zone = var.az[0]
}
