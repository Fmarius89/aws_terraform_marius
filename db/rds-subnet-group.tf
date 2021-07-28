#RDS SUBNET GROUP

provider "aws" {
    region = "us-east-1"
}

resource "aws_db_subnet_group" "wp_rds_subnetgroup" {
    name = "wp_rds_subnetgroup"
    subnet_ids = ["${var.subnets[0]}", "${var.subnets[2]}"]
}
