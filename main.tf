module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.vpc_cidr
}

module "sg" {
  source = "./modules/sg"

  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.sg.ec2_sg_id
}

module "alb" {
  source = "./modules/alb"

  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id           = module.vpc.vpc_id
  alb_sg_id        = module.sg.alb_sg_id
  asg_name         = module.ec2.asg_name
}

module "rds" {
  source = "./modules/rds"

  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.sg.ec2_sg_id
  db_username       = var.db_username
  db_password       = var.db_password
}
