output "public_ip" {
    value = "${aws_instance.terraformmachine.public_ip}"
}