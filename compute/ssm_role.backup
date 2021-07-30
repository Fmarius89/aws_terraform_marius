resource "aws_iam_role" "test_role2" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AllowServices"
        Principal = {
          Service =  ["ec2.amazonaws.com", "ssm.amazonaws.com"]
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = "${aws_iam_role.test_role2.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_ssm_activation" "foo" {
  name               = "test_ssm_activation"
  description        = "Test"
  iam_role           = "${aws_iam_role.test_role2.id}"
  registration_limit = "5"
  depends_on         = ["aws_iam_role_policy_attachment.test_attach"]
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  role = "${aws_iam_role.test_role2.name}"
}
