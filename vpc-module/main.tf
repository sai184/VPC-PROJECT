provider "aws" {
    region = "us-east-1"
    access_key = "AKIATHD5LQVACEHTXOMD"
    secret_key = "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"
    
  
}




resource "aws_vpc" "prod-vpc" {

    cidr_block = var.cidr
    instance_tenancy = "default"
  tags = {
    Name = "prod-vpc"
  }
}

resource "aws_internet_gateway" "prod-igw" {
    vpc_id = aws_vpc.prod-vpc.id
  

tags ={
    Name = "prod-igw"
}
}

resource "aws_route_table" "prod-route" {
    vpc_id = aws_vpc.prod-vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }
tags ={
    Name = "prod-route"

}  
}

resource "aws_subnet" "prod-subnet" {
     cidr_block = var.cidr-subnet
    vpc_id = aws_vpc.prod-vpc.id
   

    tags = {
        Name = "prod-subnet"
    }
  
}
#ASSWOICATE ROIUTE TABLE WITH SUBNET
resource "aws_route_table_association" "route-ass" {
  subnet_id = aws_subnet.prod-subnet.id
   route_table_id = aws_route_table.prod-route.id

}

 resource "aws_security_group" "prod_sg" { 
 vpc_id = aws_vpc.prod-vpc.id

  ingress  {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]

  }
    #from =0 and to =0 and any port it will allow protocol -1 means any protocol 
    ingress  {
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  
    
    ingress  {
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]

  }

   ingress  {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "prod_sg"
  }

}

#creating network interface for attaching elastic ip

resource "aws_network_interface" "prod-inc" {
    subnet_id = aws_subnet.prod-subnet.id
   private_ips = var.private_ips
   security_groups = [aws_security_group.prod_sg.id]
   

     
      tags = {
    Name = "prod_eip"
  }

   } 
   #attaching elastic ip
  resource "aws_eip" "prod-eip" {
    network_interface = aws_network_interface.prod-inc.id
    associate_with_private_ip = var.associate_with_private_ip
     
      tags = {
    Name = "prod_eip"
  }

   }
    #  9. Create an ec2  server - LAUNCH APLICATION IN IT 
    resource "aws_instance" "prod-server" {
        ami = var.ami
        instance_type = var.instance-type
        key_name = "nag"
        #user_data = "${file("script.sh")}"
         user_data = file("${path.module}/script.sh")
        

        network_interface {
          network_interface_id = aws_network_interface.prod-inc.id
          device_index = 0
     #Primary Network Interface: The primary network interface of an instance is always at device_index = 0.
        }
                 tags={
            Name= "prod-nag"
         }
    }

    resource "aws_s3_bucket" "cbnna" {

     bucket = "cbnna" 
     
     

  tags = {
    Name        = "cbnna"

    
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
