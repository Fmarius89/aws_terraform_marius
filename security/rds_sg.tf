# Creating a new security group for private subnet 
resource "aws_security_group" "rds_sg" {
  name        = "MYSQL_security_group"
  description = "MYSQL"
  vpc_id      =  "${var.vpc_id}"                 

  ingress {
    description = "MYSQL Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
