module "ec2" {
source = "../modules/ec2_module"
ami = "ami-09d95fab7fff3776c"
instance_type = "t2.micro"
key_name = "veeru7799"
availability_zones = "us-east-1a"
region = "us-east-1"
}

data "aws_instance" "data_apache" {
  instance_id = "i-00a4f3af7a5d682ea"

  filter {
    name   = "tag:Name"
    values = ["apache"]
  }
}

resource "null_resource" "null_apache" {
    connection {
        user = "ec2-user"
        host = "${data.aws_instance.data_apache.public_ip}"
        private_key = "${file(var.privatekeypath)}"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo yum update",
            "sudo yum install httpd -y",
            "sudo service https status"
        ]
    }
}
