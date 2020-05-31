resource "aws_vpc" "TerraformVPC1" {
  cidr_block = "${var.cidr_block}"
  tags = {
    Name = "TerraformVPC"
  }
}


