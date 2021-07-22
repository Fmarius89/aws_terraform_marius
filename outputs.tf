output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value = module.compute.ec2_private_instance_ids
}
