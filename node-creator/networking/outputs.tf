output "vpc_id" {
  value = aws_vpc.runners.id
}

output "private_subnet_id"{
  value = aws_subnet.runners_private.id
}

output "public_subnet_id"{
  value = aws_subnet.runners_public.id
}

output "eip" {
  value = aws_eip.runners_nat.public_ip
}

