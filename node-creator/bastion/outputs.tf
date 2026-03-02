output "bastion_ip"{
    value = aws_instance.bastion-host.public_ip
}

output "ssh_key_name"{
    value = aws_key_pair.bastion_key.key_name
}