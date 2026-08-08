output "deployment_bucket_name" {
  value = module.s3_bucket.s3_bucket_id
}

output "instance_id" {
  value = module.ec2_instance.id
}

output "instance_name" {
  value = module.ec2_instance.name
}
