resource "aws_db_instance" "default" {
  identifier           = "sample"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "wordpress"
  username             = data.aws_ssm_parameter.dbusername.value
  password             = data.aws_ssm_parameter.dbpassword.value
  skip_final_snapshot  = true
  db_subnet_group_name = "${aws_db_subnet_group.wp_rds_subnetgroup.name}"
  vpc_security_group_ids = ["${var.rds_sg}"]

} 

data "aws_ssm_parameter" "dbpassword" {
  name = "/A4L/Wordpress/DBPassword"
}

data "aws_ssm_parameter" "dbusername" {
  name = "/A4L/Wordpress/DBUser"
}
