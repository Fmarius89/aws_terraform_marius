terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "fmarius-test-terraform-tfstate"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = false
  }
}
