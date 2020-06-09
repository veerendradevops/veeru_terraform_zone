resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.core_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.core_igw.id}"
  }

  tags = "${merge(var.common_tags, map(
    "Name", "${var.route_table_public_name}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_route_table" "privdmz" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.core_vpc.id}"

  tags = "${merge(var.common_tags, map(
    "Name", "${var.route_table_privdmz_names[count.index]}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_route" "privdmz_routes_nat" {
  count                  = "${length(var.availability_zones)}"
  route_table_id         = "${aws_route_table.privdmz.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.core_nat.*.id[count.index]}"
  depends_on             = ["aws_route_table.privdmz"]
}

### We multiply lenghts in count in order to be able to use different counts in the resource. Similar to nested loop.
resource "aws_route" "privdmz_routes" {
  count                  = "${length(var.availability_zones) * length(var.privdmz_routes_cidrs)}"
  route_table_id         = "${aws_route_table.privdmz.*.id[count.index % length(var.availability_zones)]}"
  destination_cidr_block = "${var.privdmz_routes_cidrs[count.index / length(var.availability_zones)]}"
  transit_gateway_id     = "${var.transit_gateway_id}"
  depends_on             = ["aws_route_table.privdmz"]
}

resource "aws_route_table" "private" {
  count  = "${lookup(var.subnets_cidrs, "${var.environment}.appdbl-0", "") != "" ? 1 : 0}"
  vpc_id = "${aws_vpc.core_vpc.id}"

  tags = "${merge(var.common_tags, map(
    "Name", "${var.route_table_private_name}",
    "VPC", "${var.vpc_name}"
  ))}"
}

resource "aws_route_table_association" "route-assoc-dmz" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.pubdmz_sub.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "route-assoc-web" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.privdmz_sub.*.id, count.index)}"
  route_table_id = "${aws_route_table.privdmz.*.id[count.index]}"
}

resource "aws_route_table_association" "route-assoc-appdb" {
  count          = "${lookup(var.subnets_cidrs, "${var.environment}.appdbl-0", "") != "" ? length(var.availability_zones) : 0}"
  # count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.private_sub.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
