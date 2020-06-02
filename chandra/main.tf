resource "aws_instance" "first_ec2" {
    ami = "ami-09d95fab7fff3776c"
    instance_type = "t2.micro"
    key_name = "veeru7799"
    vpc_security_group_ids = ["var.securitygroupid"]
    associate_public_ip_address = true
    tags    =   {
        Name = "chandraEC2"
    }
}