provider "aws" {
    shared_config_files      = ["/home/$USER/.aws/config"]
    shared_credentials_files = ["/home/$USER/.aws/credentials"]
}

module "networking" {
  source = "./networking"
}

module "bastion" {
  source = "./bastion"

  bastion_subnet = module.networking.public_subnet_id
  bastion_vpc = module.networking.vpc_id
  bastion_type = "t3.micro"
  bastion_key = file("${path.module}/.ssh/bastion-key.pub")
  depends_on = [ module.networking ]
}

module "runners" {
  source = "./runners"

  runner_type = "t3.micro"
  runner_vpc = module.networking.vpc_id
  runner_subnet = module.networking.private_subnet_id
  ssh_key_name = module.bastion.ssh_key_name
  bastion_ip = module.bastion.bastion_ip
  runners_count = 3


  depends_on = [ module.bastion, module.networking ]
}


# Need to create:
# Auto Scaling Group