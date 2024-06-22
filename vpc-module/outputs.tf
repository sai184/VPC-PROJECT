output "public-ip" {

  value = aws_eip.prod-eip.public_ip
}