resource "aws_vpc" "mainnet" {
    cidr_block = "192.168.0.0/16"

    tags = {
        Name = "mainnet-${terraform.workspace}"
    }
  
}

resource "aws_subnet" "websubnet" {
    vpc_id = "${aws_vpc.mainnet.id}"
    cidr_block = "192.168.0.0/24"
}


resource "aws_subnet" "businesssubnet" {
    vpc_id = "${aws_vpc.mainnet.id}"
    cidr_block = "192.168.1.0/24"
}


resource "aws_subnet" "datasubnet" {
    vpc_id = "${aws_vpc.mainnet.id}"
    cidr_block = "192.168.2.0/24"
}