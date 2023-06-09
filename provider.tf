provider "aws" {
access_key = var.access_key
secret_key = var.secret_key
region = var.region
}
module "vpc"{
  source = "./modules/vpc"
}
module "EC2"{
  source = "./modules/EC2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}
module "ALB" {
  source = "./modules/ALB"
  vpc_id = module.vpc.vpc_id
  instance_id = module.EC2.instance-id
  public_subnet = [module.vpc.subnet_id,module.vpc.Subnet_ID]
}
