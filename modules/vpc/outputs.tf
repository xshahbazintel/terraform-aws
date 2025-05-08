output "vpc_cidr_range" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_arn" {
  value = aws_vpc.vpc.arn
}