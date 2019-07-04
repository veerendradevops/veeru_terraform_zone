#terraform apply -var="accesskey=" -var="secretkey=" -var="privatekeypath=D:\veeru\terraform_sample_june2019\vkaws.pem" . -out plan.txt
provider "aws"{

    region = "us-east-1"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}" 
}
resource "aws_security_group" "tf_sg_all" {

name = "tf_sg_all"
description = "All inbound traffic"
vpc_id = "vpc-adc0a0d7"
ingress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}  
egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_instance" "terraform_ansible" {
    ami = "ami-024a64a6685d05041"
    instance_type = "t2.micro"
    key_name = "vkaws"
    security_groups = ["${aws_security_group.tf_sg_all.name}"]
    connection {
        user = "ubuntu"
        host = "${aws_instance.terraform_ansible.public_ip}"
        private_key = "${file(var.privatekeypath)}"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get install ansible -y"
        ]
    }
  
}


