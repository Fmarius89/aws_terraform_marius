# Private EC2 Instances
## ec2_private_instance_ids
output "ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       =  "${aws_instance.tf_server.*.id}"
}

output "ebs_volume_id" {
  value = "${aws_ebs_volume.example.*.id}"

}

output "target_id" {
  value = "${aws_instance.tf_server.*.id}"
}
