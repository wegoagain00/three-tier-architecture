provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "frontend_ec2" {
  source             = "./modules/ec2"
  instance_type      = "t2.micro"
  ami                = "ami-0f4f4482537714bd9"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.frontend_sg_id]
  key_name           = "newest-key"

  tags = {
    Name = "three-tier-frontend"
  }
}

module "backend_ec2" {
  source             = "./modules/ec2"
  instance_type      = "t2.micro"
  ami                = "ami-0f4f4482537714bd9"
  subnet_id          = module.vpc.private_subnet_ids[0]
  security_group_ids = [module.vpc.backend_sg_id]
  key_name           = "newest-key"

  tags = {
    Name = "three-tier-backend"
  }
}

module "rds" {
  source            = "./modules/rds"
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.vpc.database_sg_id
  db_username       = "admin"
  db_password       = aws_secretsmanager_secret_version.db_password.secret_string
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "db_password" {
  name = "rds_db_password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}
