data "aws_instance" "terraform_instance_data" {
  instance_id = "i-01ffc1c9e05104866"

}
resource "null_resource" "test" {
  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("./vksonata.pem")}"
     // host = "${data.aws_instance.terraform_instance_data.public_ip}"
       //host = "${element(aws_instance.cluster.*.public_ip, 0)}"
      host = "${element(data.aws_instance.terraform_instance_data.*.public_ip, 0)}"
  }
  provisioner "remote-exec" {
      inline = [
          "sudo apt-get update -y",
          "sudo apt-get install nginx -y"
      ]
  }
}

