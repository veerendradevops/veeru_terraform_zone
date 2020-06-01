resource "aws_instance" "terraformmachine" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.tf_sg.name}"]
  availability_zone ="${var.availability_zones}"

    tags = {
    Name      = "${var.environment_tag}"
connection {
        user = "ec2-user"
        host = "${aws_instance.terraformmachine.public_ip}"
        private_key = "${file(var.privatekeypath)}"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo yum update",
            "sudo yum httpd -y"
        ]
    }
}