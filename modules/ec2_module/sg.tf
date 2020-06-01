resource "aws_security_group" "tf_sg_all" {

name = "tf_sg_apache"
description = "Allows traffic on port 80"
vpc_id = "vpc-90e6ebea"
ingress{
    from_port = 80
    to_port = 80
    protocol = "tdp"
    cidr_blocks = ["0.0.0.0/0"]
} 
ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
} 
egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}