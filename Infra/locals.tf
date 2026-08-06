locals {
  security_group_ingress_rules = {
    ssh = {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = var.allowed_ssh_cidr
    }
    http = {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  common_tags = {
    Project     = "Example Voting App"
    Terraform   = "true"
    Environment = "dev"
  }
}