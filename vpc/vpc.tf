data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
    cidr_block = "10.16.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support    = true
    tags = {
      Name = "A4L-VPC"
}
}
    


resource "aws_subnet" "sn-app" {
     count = 3
     vpc_id = "${aws_vpc.tf_vpc.id}"
     cidr_block = "${var.app_cidrs[count.index]}"
     map_public_ip_on_launch = true
     availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
     
     tags = {
        Name = "sn-app-${data.aws_availability_zones.available.names[count.index]}"
 }
}

resource "aws_subnet" "sn-web" {
     count = 3
     vpc_id = "${aws_vpc.tf_vpc.id}"
     cidr_block = "${var.web_cidrs[count.index]}"
     map_public_ip_on_launch = true
     availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
     
     tags = {
        Name = "sn-web-${data.aws_availability_zones.available.names[count.index]}"
 }
}

resource "aws_subnet" "sn-db" {
     count = 3
     vpc_id = "${aws_vpc.tf_vpc.id}"
     cidr_block = "${var.db_cidrs[count.index]}"
     map_public_ip_on_launch = true
     availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
     
     tags = {
        Name = "sn-db-${data.aws_availability_zones.available.names[count.index]}"
 }
}



resource "aws_internet_gateway" "tf_internet_gateway" {
    vpc_id = "${aws_vpc.tf_vpc.id}"

    tags = {
         Name = "tf_igw_marius"
 }
}

resource "aws_route_table" "tf_public_rt" {
    vpc_id = "${aws_vpc.tf_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.tf_internet_gateway.id} "
 }
    tags = {
        Name = "tf_public_marius"
 }
}
resource "aws_default_route_table" "tf_private_rt" {
     default_route_table_id = "${aws_vpc.tf_vpc.default_route_table_id}"
     tags = {
         Name = "tf_private_marius"
 }
}

resource "aws_route_table_association" "tf_public_assoc" {
     count = "${length(aws_subnet.sn-web)}"
     subnet_id = "${aws_subnet.sn-web.*.id[count.index]}"
     route_table_id = "${aws_route_table.tf_public_rt.id}"
}



