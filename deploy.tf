provider "aws" {
    region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
     app_cidrs = "${var.app_cidrs}"
     web_cidrs = "${var.web_cidrs}"
     db_cidrs = "${var.db_cidrs}"
     target_id = "${module.compute.target_id}"
     vpc_id = "${module.vpc.vpc_id}"
     public_sg = "${module.security.public_sg}"
}

module "compute" {
    source = "./compute"
    subnets = "${module.vpc.public_subnets}"
    security_group = "${module.security.public_sg}"
    ec2_ids = "${module.compute.ec2_private_instance_ids}"
    ebs_volume_id = "${module.compute.ebs_volume_id}"
    public_ip = module.vpc.subnet_ips
    target_id = "${module.compute.target_id}"
    iam_ssm = "${module.iam.iam_ssm}"
    ami_id = "${var.ami_id}"
    depends_on = [module.db]
}


module "bucket" {
    source = "./bucket" 
    project_name = "${var.project_name}"
}

module "db" {
   source = "./db"
   db_subnets = "${module.vpc.db_subnets}"
   vpc_id = "${module.vpc.vpc_id}"
   rds_sg = "${module.security.rds_sg}"
}

module "iam" {
    source = "./iam"
    iam_ssm = "${module.iam.iam_ssm}"
}

module "security" {
    source = "./security"
    vpc_id = "${module.vpc.vpc_id}"
    public_sg = "${module.security.public_sg}"
    rds_sg = "${module.security.rds_sg}"
}


