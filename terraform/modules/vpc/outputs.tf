output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpccidrblock" {
  value = awsvpc.main.cidrblock
}

output "publicsubnetids" {
  value = [awssubnet.public1.id, awssubnet.public2.id]
}

output "publicsubnetcidr_blocks" {
  value = [
    awssubnet.public1.cidr_block,
    awssubnet.public2.cidr_block,
  ]
}

output "privatesubnetid" {
  value = aws_subnet.private.id
}

output "privatesubnetcidr_block" {
  value = awssubnet.private.cidrblock
}

output "privatedbsubnet_ids" {
  value = [
    awssubnet.privatedb_a.id,
    awssubnet.privatedb_b.id,
    awssubnet.privatedb_c.id
  ]
}

output "privatedbsubnetcidrblocks" {
  value = [
    awssubnet.privatedba.cidrblock,
    awssubnet.privatedbb.cidrblock,
    awssubnet.privatedbc.cidrblock
  ]
}

