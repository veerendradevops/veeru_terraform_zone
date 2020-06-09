resource "aws_subnet" "pubdmz_sub" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.core_vpc.id}"
  cidr_block        = "${lookup(var.subnets_cidrs, "${var.environment}.dmzl-${count.index}")}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.common_tags, map(
    "Name", "${var.source_market_name}-${var.environment}-${lookup(var.subnet_names, "dmzl-${count.index}")}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_subnet" "privdmz_sub" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.core_vpc.id}"
  cidr_block        = "${lookup(var.subnets_cidrs, "${var.environment}.webl-${count.index}")}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.common_tags, map(
    "Name", "${var.source_market_name}-${var.environment}-${lookup(var.subnet_names, "webl-${count.index}")}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_subnet" "private_sub" {
  count             = "${lookup(var.subnets_cidrs, "${var.environment}.appdbl-0", "") != "" ? length(var.availability_zones) : 0}"
  vpc_id            = "${aws_vpc.core_vpc.id}"
  cidr_block        = "${lookup(var.subnets_cidrs, "${var.environment}.appdbl-${count.index}")}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.common_tags, map(
    "Name", "${var.source_market_name}-${var.environment}-${lookup(var.subnet_names, "appdbl-${count.index}")}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_db_subnet_group" "db_sub_groups" {
  count = "${lookup(var.subnets_cidrs, "${var.environment}.appdbl-0", "") != "" ? length(var.db_sub_groups_names) : 0}"
  # count = "${length(var.db_sub_groups_names)}"

  name        = "${element(var.db_sub_groups_names, count.index)}"
  description = "DB Subnet Groups"
  subnet_ids  = ["${aws_subnet.private_sub.*.id}"]

  tags = "${merge(var.common_tags, map(
    "Name", "${element(var.db_sub_groups_names, count.index)}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_network_acl" "nacl" {
  vpc_id = "${aws_vpc.core_vpc.id}"

  egress {
    protocol   = "all"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = ["${aws_subnet.pubdmz_sub.*.id}", "${aws_subnet.privdmz_sub.*.id}", "${aws_subnet.private_sub.*.id}"]

  tags = "${merge(var.common_tags, map(
    "Name", "${var.nacl_name}",
    "VPC", "${var.vpc_name}"
  ))}"
}
