# Create an EBS volume, snapshot it, create an AMI from the snapshot, copy the AMI to another region, and launch an EC2 instance with user data.

# Create an EBS volume in the specified availability zone
resource "aws_ebs_volume" "ebs_vol_01" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type
  tags = merge(var.tags, {
    Name = "TF_EBS_Volume_01"
  })
}


# Create a snapshot of the EBS volume 
resource "aws_ebs_snapshot" "ebs_vol_01_snapshot" {
  volume_id = aws_ebs_volume.ebs_vol_01.id
  tags      = var.tags
}



# Create an AMI from the EBS volume snapshot
resource "aws_ami" "TF-AMI-01" {
  name                = "terraform-example"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  imds_support        = "v2.0"
  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = "snap-072ed1789d6546138"
    volume_size = var.size
  }
}


# Copy the AMI to a different region
resource "aws_ami_copy" "Golden_AMI_Copy" {
  name              = "Golden_AMI"
  source_ami_id     = aws_ami.TF-AMI-01.id
  source_ami_region = var.source_ami_region
  tags              = merge(var.tags, {
    Name = "Golden_AMI_Copy"
  })
  provider          = aws.destination
}  


# Create an EC2 instance with user data 

resource "aws_instance" "firstvm" {
  ami           = aws_ami.TF-AMI-01.id
  instance_type = "t2.micro"
  key_name      = "practice-key-pair"
  user_data     = file(var.user_data)
  tags          = merge(var.tags, {
    Name = "First_VM"
  })
}  
