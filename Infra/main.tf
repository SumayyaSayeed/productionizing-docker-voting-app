module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name          = var.instance_name
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = data.aws_subnets.default.ids[0]

  create_security_group        = true
  security_group_ingress_rules = local.security_group_ingress_rules

  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    AmazonS3ReadOnlyAccess       = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  user_data = local.user_data

  tags = local.common_tags
}
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}