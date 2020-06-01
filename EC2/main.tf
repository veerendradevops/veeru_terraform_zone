module "ec2" {
source = "../modules/ec2_module"
ami = "ami-09d95fab7fff3776c"
instance_type = "t2.micro"
key_name = "veeru7799"
availability_zones = "us-east-1a"
region = "us-east-1"
}
####Note: To use below datasources & null resource, you need to create a ec2 machine using above code, else you may get an error #####
