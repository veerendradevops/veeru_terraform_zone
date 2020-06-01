resource "aws_instance" "terraformmachine" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.tf_sg.name}"]
  availability_zone ="${var.availability_zones}"

    tags = {
    Name      = "${var.environment_tag}"
}
}

output "instance_ip_addr" {
  value       = aws_instance.terraformmachine.id
  description = "The private IP address of the main server instance."
}

