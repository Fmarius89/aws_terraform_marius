variable "app_cidrs" {
     default = [
         "10.16.32.0/20",
         "10.16.96.0/20",
         "10.16.160.0/20"
]
}

variable "web_cidrs" {
     type = list(string)
     default = [
         "10.16.48.0/20",
         "10.16.112.0/20",
         "10.16.176.0/20"
]
}

variable "db_cidrs" {
     type = list(string)
     default = [
         "10.16.16.0/20",
         "10.16.80.0/20",
         "10.16.144.0/20"
]
}

variable "accessip" {
     default = "0.0.0.0/0"
}

variable "target_id" {
     type = list(string)
}

variable "vpc_id"{}


variable "public_sg" {}
