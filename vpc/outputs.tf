#-------networking/outputs.tf

output "public_subnets" {
    value = aws_subnet.sn-web.*.id
}

output "subnet_ips" {
    value = "${aws_subnet.sn-web.*.cidr_block}"
}

output "db_subnets" {
    value = aws_subnet.sn-db.*.id
}

output "vpc_id" {
    value = "${aws_vpc.tf_vpc.id}"
}
