resource "aws_instance" "first_ec2" {
    ami = ""
    instance_type = ""
    key_name = ""
    vpc_security_group_ids = ""
    associate_public_ip_address = true
    tags    =   {
        Name = "chandraEC2"
    }
}