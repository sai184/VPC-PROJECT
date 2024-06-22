variable "cidr" {
    description = "proving cidr range"
    default = "10.81.0.0/16"
  
}
variable "cidr-subnet" {
    description = "providing subnet cidr"
    default = "10.83.3.0/24"
  
}
variable "private_ips" {
    description = "providing private ips"
    default = ["10.81.3.33"]
}
variable "associate_with_private_ip" {
  
   default = "10.81.3.33"

}
variable "elastic-ip" {
    description = "providing elastic ip"
    default = "10.81.3.33"
  
}

variable "ami" {

    default = "ami-00beae93a2d981137"
  
}
variable "instance-type" {
    default = "t2.micro"
  
}
variable "key-name" {
    default = "nag"
  
}

