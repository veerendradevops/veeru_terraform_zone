output "public_ip" {
    apache_url = http://"${aws_instance.terraformmachine.public_ip}":80
}