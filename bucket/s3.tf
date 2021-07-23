#Create a random id
resource "random_id" "tf_bucket_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "b" {
  #bucket = "my-tf-test-bucket-fetti"
  #bucket        = "${var.project_name}-${random_id.tf_bucket_id.dec}"
  bucket = "${random_id.tf_bucket_id.dec}"
   acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
