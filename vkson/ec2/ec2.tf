provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}

resource "aws_instance" "terraformmachine" {
  ami = "ami-0cfee17793b08a293"
  instance_type = "t2.micro"
  key_name = "vksonata"
  availability_zone = "us-east-1a"
  security_groups = ["alltrafficsonata"]

  tags = {
      Name = "terraform_instance"
  }
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = "${file("./vksonata.pem")}"
     host = "${aws_instance.terraformmachine.public_ip}"
 }
 provisioner "remote-exec" {
     inline = [
         "sudo apt-get update",
         "sleep 10",
         "sudo apt-get update",
         "sleep 10",
         "sudo apt-get install tomcat8 -y",
         "sleep 10",
         "sudo apt-get update"

         
         
     ]
 }

 
}


resource "aws_security_group" "alltrafficsonata" {
  name = "alltrafficsonata"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
