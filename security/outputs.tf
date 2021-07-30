output "public_sg" {
    value = "${aws_security_group.tf_public_sg.id}"
}

output "rds_sg" { 
    value = "${aws_security_group.rds_sg.id}"
}
