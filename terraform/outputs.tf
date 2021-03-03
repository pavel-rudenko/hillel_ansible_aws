output "dev_public_ip" {
  value = aws_instance.dev.public_ip
}
output "prod_public_ip" {
  value = aws_instance.prod.public_ip
}