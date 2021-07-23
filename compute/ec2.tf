#-------computer/main.tf

#resource "tls_private_key" "dev_key" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "aws_key_pair" "generated_key" {
#  key_name   = var.generated_key_name
#  public_key = tls_private_key.dev_key.public_key_openssh

#  provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
#    command = "echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem"
#  }

#  provisioner "local-exec" {
#    command = "chmod 400 ./'${var.generated_key_name}'.pem"
#  }
#}


data "aws_ami" "server_ami" {
    most_recent = true

    owners = ["amazon"]

    filter {
       name = "owner-alias"
       values = ["amazon"]
}

    filter {
       name = "name"
       values = ["amzn-ami-hvm*-x86_64-gp2"]
 }
}

resource "aws_instance" "tf_server" {
     count = 3
     instance_type = "t2.micro"
     ami = "${data.aws_ami.server_ami.id}"
     subnet_id = "${var.subnets[count.index]}"
     #key_name = aws_key_pair.generated_key.key_name
     key_name = "fetti"
     vpc_security_group_ids = ["${var.security_group}"]
     tags = { 
       Name = "Marius-VM-${count.index}"
    }
    
    provisioner "remote-exec" {
    inline = [
      "sudo yum -y install docker"
    ]
  }

    
    connection {
    type     = "ssh"
    host     = "${var.public_ip[count.index]}"    
    #host     = "${element(var.public_ip, count.index)}"
    user     = "ec2-user"
    private_key = file("/tmp/fetti.pem")
  }  

 
}


#Add EBS Volume:

resource "aws_volume_attachment" "ebs_att" {
  count = 1
  device_name = "/dev/sdh"
  volume_id   =  "${element(var.ebs_volume_id, count.index)}"
  instance_id = "${element(var.ec2_ids, count.index)}"
}


resource "aws_ebs_volume" "example" {
  count = 1
  availability_zone = "us-east-1a"
  size              = 1
}


resource "aws_ebs_snapshot" "example_snapshot" {
  count = 1
  volume_id = "${element(var.ebs_volume_id, count.index)}"

  tags = {
    Name = "Some-snap-shot"
  }
}
