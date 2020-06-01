module "ec2" {
source = "../modules/ec2_module"
ami = "ami-09d95fab7fff3776c"
instance_type = "t2.micro"
key_name = "veeru7799"
availability_zones = "us-east-1a"
region = "us-east-1"
}
####Note: To use below datasources & null resource, you need to create a ec2 machine using above code, else you may get an error #####

data "aws_instance" "data_apache" {
  instance_id = "i-039e64f3223a255e8"

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
            "sudo yum update -y",
            "sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
            "sudo yum install epel-release-latest-7.noarch.rpm",
            "sudo yum update -y",
            "sudo  yum install git python python-devel python-pip ansible -y"
        ]
    }
}
