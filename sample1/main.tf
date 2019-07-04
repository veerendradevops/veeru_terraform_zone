provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}
resource "aws_security_group" "alltraffic1" {
  name        = "alltraffic1"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-adc0a0d7"

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
resource "aws_instance" "terraformmachine" {
  
  ami = "ami-024a64a6685d05041"
  instance_type="t2.micro"
  key_name="vkaws"
  security_groups=["${aws_security_group.alltraffic1.name}"]

connection {

    user="ubuntu"
    private_key="${file(var.privatekey)}"
}
provisioner "remote-exec" {

    inline= ["sudo apt-get update -y",
            "sudo apt-get install tomcat7 -y"]
}
}


