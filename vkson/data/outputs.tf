output "publicip" {
  value = "${data.aws_instance.terraform_instance_data.public_ip}"
}