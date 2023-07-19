locals {
  vpc_id = module.this.vpc_id
  db_subnet_group_name = module.this.db_subnet_group_name
}

output "vpc_id" {
  value = local.vpc_id
}


