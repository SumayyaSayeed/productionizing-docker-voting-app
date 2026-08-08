variable "instance_name" {
  default     = "voting_app_ec2"
  description = "Instance name"
}
variable "instance_type" {
  default     = "t3.micro"
  description = "ec2 instance type"
}
variable "key_name" {
  default     = "ec2-keypair"
  description = "Key pair name"
}
variable "allowed_ssh_cidr" {
  default     = "0.0.0.0/0"
  description = "CIDR block for SSH access"
}
variable "bucket_name" {
  default     = "votingappbucket"
  description = "S3 bucket name"
}