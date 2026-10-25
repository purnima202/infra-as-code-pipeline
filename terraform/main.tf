
module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = local.environment
  aws_region   = var.aws_region
  vpc_cidr     = "10.0.0.0/16"
}

module "security" {
  source = "./modules/security"

  project_name   = var.project_name
  environment    = local.environment
  vpc_id         = module.networking.vpc_id
  container_port = var.container_port
}

module "compute" {
  source = "./modules/compute"

  project_name          = var.project_name
  environment           = local.environment
  aws_region            = var.aws_region
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id
  container_port        = 80
  desired_count         = 2
}

module "monitoring" {
  source = "./modules/monitoring"

  project_name     = var.project_name
  environment      = local.environment
  ecs_cluster_name = module.compute.ecs_cluster_name
  ecs_service_name = module.compute.ecs_service_name
}