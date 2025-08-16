# Create a new load balancer
resource "aws_elb" "awsclassic_elb" {
  name               = var.elb_name
  availability_zones = var.availability_zones


  listener {
    instance_port     = var.listener.instance_port
    instance_protocol = var.listener.instance_protocol
    lb_port           = var.listener.lb_port
    lb_protocol       = var.listener.lb_protocol
  }


  health_check {
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    timeout             = var.health_check.timeout
    target              = var.health_check.target
    interval            = var.health_check.interval
  }

  instances                   = [aws_instance.app-01.id, aws_instance.app-02.id]
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  tags = var.tags
}

# Create a new App EC2 instance
resource "aws_instance" "app-01" {
  ami           = var.ami_ids[0]
  instance_type = var.instance_type

  tags = var.prd_ec2_instance_tags
}

# Create a new App EC2 instance
resource "aws_instance" "app-02" {
  ami           = var.ami_ids[1]
  instance_type = var.instance_type

  tags = var.stg_ec2_instance_tags
}

# attach ec2 instances to the load balancer
resource "aws_elb_attachment" "elb-attachment-01" {
  elb      = aws_elb.awsclassic_elb.id
  instance = aws_instance.app-01.id
}

resource "aws_elb_attachment" "elb-attachment-2" {
  elb      = aws_elb.awsclassic_elb.id
  instance = aws_instance.app-02.id
}
