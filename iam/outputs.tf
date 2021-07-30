output "iam_ssm" {
  value = "${aws_iam_instance_profile.test_profile.name}"
}
