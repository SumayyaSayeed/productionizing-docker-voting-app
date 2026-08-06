module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name          = var.instance_name
  instance_type = var.instance_type
  key_name      = var.key_name

  create_security_group        = true
  security_group_ingress_rules = local.security_group_ingress_rules
    user_data = var.user_data

  tags = local.common_tags
}