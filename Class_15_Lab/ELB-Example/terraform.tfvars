elb_name = "L4-classic-terraform-elb"
availability_zones = [ "us-east-1a","us-east-1b" ]



listener = {
  instance_port = 8000
  instance_protocol = "http"
  lb_port = 80
  lb_protocol = "http"
}


health_check = {
  healthy_threshold = 2
  unhealthy_threshold = 2
  timeout = 3
  target = "HTTP:8000/"
  interval = 30
}

ami_ids = [ "ami-0de716d6197524dd9","ami-0e1989e836322f58b" ]

cross_zone_load_balancing = true

idle_timeout = 400

connection_draining = true

connection_draining_timeout = 400

tags = {
  "name" = "practice-terraform deployment"
}


prd_ec2_instance_tags = {
  "Name" = "Prod-01"
}

stg_ec2_instance_tags = {
  "Name" = "STG-01"
}
