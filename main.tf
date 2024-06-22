provider "aws" {

    region = "us-east-1"
  
}
module "vpc-module" {
source="./vpc-module"
cidr = "10.83.0.0/16"
cidr-subnet = "10.83.3.0/24"
private_ips = ["10.83.3.33"]
associate_with_private_ip = "10.83.3.33"
elastic-ip = "10.83.3.33"
ami = "ami-00beae93a2d981137"
instance-type = "t2.micro"
key-name = "nag"  
  
}