variable "subnets" {
    type = list(string)
  }

variable "security_group" {}

variable "generated_key_name" {
  type        = string
  default     = "terraform-key-pair"
  description = "Key-pair generated by Terraform"
}

variable "ec2_ids" {
    type = list(string)
}

variable "ebs_volume_id" {
    type = list(string)
}
