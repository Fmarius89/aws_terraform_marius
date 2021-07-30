resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.public_sg}"]
  subnets            =  aws_subnet.sn-web.*.id

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.tf_vpc.id}"
}

resource "aws_lb_target_group_attachment" "test" {
   count = 3
   target_group_arn = "${aws_lb_target_group.test.arn}"
   target_id = "${var.target_id[count.index]}"
   port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port = 80
  protocol = "HTTP"

  default_action {
  type = "forward"
  target_group_arn = "${aws_lb_target_group.test.arn}"
 }
}

