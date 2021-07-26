provider "aws" {
    region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
     app_cidrs = "${var.app_cidrs}"
     web_cidrs = "${var.web_cidrs}"
     db_cidrs = "${var.db_cidrs}"
     target_id = "${module.compute.target_id}"    
}

module "compute" {
    source = "./compute"
    subnets = "${module.vpc.public_subnets}"
    security_group = "${module.vpc.public_sg}"
    ec2_ids = "${module.compute.ec2_private_instance_ids}"
    ebs_volume_id = "${module.compute.ebs_volume_id}"
    public_ip = module.vpc.subnet_ips
    target_id = "${module.compute.target_id}"
}


module "bucket" {
    source = "./bucket" 
    project_name = "${var.project_name}"
}
