provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentails"
    profile                 = "default"
}

resource "aws_security_group" "tf_sg" {

name = "tf_sg"
description = "Allows traffic on port 80"
vpc_id = "vpc-90e6ebea"
ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
} 
ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
} 
egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "terraformmachine" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.tf_sg.name}"]
  availability_zone ="${var.availability_zones}"

    tags = {
    Name      = "${var.environment_tag}"
    }
connection {
        user = "ec2-user"
        host = "${aws_instance.terraformmachine.public_ip}"
        private_key = "${file(var.privatekeypath)}"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
            "sudo yum install epel-release-latest-7.noarch.rpm -y",
            "sudo yum update -y",
            "sudo  yum install git python python-devel python-pip ansible -y",
            "sudo chmod 777 /etc/ansible/hosts",
            "sudo echo '127.0.0.1 ansible_connection=local' > /etc/ansible/hosts"
        ]
    }
}