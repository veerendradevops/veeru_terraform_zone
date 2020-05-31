#Note: cidrsubnet(), element() are terraform functions

resource "aws_subnet" "vkdmzsubnets" {
  vpc_id     = "${aws_vpc.TerraformVPC1.id}"
  cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"
  count      = "${length(var.availability_zones)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = {
    "Name" = "vkpublicsubnet - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_subnet" "vkwebsubnets" {
  vpc_id     = "${aws_vpc.TerraformVPC1.id}"
  cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))}"
  count      = "${length(var.availability_zones)}"
  availability_zone = "${element(var.availability_zones, count.index )}"

  tags = {
    "Name" = "vknatsubnet - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_subnet" "vkprivatesubnets" {
  vpc_id     = "${aws_vpc.TerraformVPC1.id}"
  cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones) + length(var.availability_zones))}"
  count      = "${length(var.availability_zones)}"
  availability_zone = "${element(var.availability_zones, count.index )}"

  tags = {
    "Name" = "vkprivatesubnet - ${element(var.availability_zones, count.index)}"
  }
}
