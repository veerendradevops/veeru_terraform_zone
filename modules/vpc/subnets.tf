resource "aws_subnet" "vksubnets" {
  vpc_id     = "${aws_vpc.TerraformVPC1.id}"
  cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"
  count      = "${length(var.availability_zones)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = {
    "Name" = "vktfsubnet - ${element(var.availability_zones, count.index)}"
  }
}
