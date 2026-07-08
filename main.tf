module "network" {
  source = "./modules/network"

  project_name     = var.project_name
  vpc_cidr         = var.vpc_cidr
  subnetipPublic   = var.subnetipPublic
  subnetipPrivate  = var.subnetipPrivate
  subnetipPrivate1 = var.subnetipPrivate1
  subnetipPublic1  = var.subnetipPublic1
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id
}

module "alb" {

  source = "./modules/alb"

  project_name = var.project_name

  vpc_id = module.network.vpc_id

  public_subnet_ids = module.network.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

}

module "ecs" {

  source = "./modules/ecs"

  project_name = var.project_name

  aws_region = var.aws_region

  container_image = var.container_image

  private_subnet_ids = module.network.private_subnet_ids

  ecs_security_group_id = module.security.ecs_security_group_id

  target_group_arn = module.alb.target_group_arn

}


module "rds" {

  source = "./modules/RDS"

  project_name          = var.project_name
  private_subnet_ids    = module.network.private_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id

  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password

  db_instance_class     = "db.t3.micro"
  allocated_storage     = 20

  environment           = "dev"
  backup_retention_period = 1
  deletion_protection   = false
}







