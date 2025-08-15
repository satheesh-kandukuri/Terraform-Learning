resource "aws_instance" "test-vm-01" {
  ami           = var.ami
  instance_type = var.instance_type
}




 