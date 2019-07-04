##terraform apply -var="accesskey=" -var="secretkey=" -var="privatekeypath=D:\veeru\terraform_sample_june2019\vkaws.pem" .
provider "aws" {
  
  region = "us-east-1"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
resource "aws_security_group" "alltraffic" {
  
  name        = "docker_tf_sg"
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
resource "aws_instance" "terraform_docker" {
    ami = "ami-024a64a6685d05041"
  instance_type="t2.micro"
  key_name="vkaws"
  security_groups=["${aws_security_group.alltraffic.name}"]

  connection {

    user="ubuntu"
    host        = "${aws_instance.terraform_docker.public_ip}"
    private_key="${file(var.privatekeypath)}"
}
provisioner "remote-exec"{
    inline = [
        "sudo apt-get update",
        "curl -fsSL https://get.docker.com -o get-docker.sh",
        "sudo sh get-docker.sh",
        "sudo usermod -aG docker ubuntu",
        "docker login -u veerendratholeti@gmail.com -p "
    ]
}
  
}
