output "vpc_id" {
  value = aws_vpc.phineart_vpc.id

}
output "ec2_public_ip" {
  value = module.phineart_module.ec2_public_ip

} 