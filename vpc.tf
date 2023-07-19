module "this" {
  source = "../terraform-aws-vpc-practice"
  project_name = var.project_name
  cidr_block = var.cidrblockofvpc
  vpc_tags = var.commontags
  igw_tags = var.commontags
  public_subnets_cidr = var.public_subnets_cidr
  public_subnet_tags = var.commontags
  private_subnets_cidr = var.private_subnets_cidr
  private_subnet_tags = var.commontags
  public_route_table_tags = var.commontags
  private_route_table_tags = var.commontags
  nat_gateway_tags = var.commontags
  database_subnets_cidr = var.database_subnets_cidr
  database_subnet_tags = var.commontags
  database_route_table_tags = var.commontags
  db_subnet_group_tags = var.commontags

/*   public_route_table_tags = merge(
    var.commontags,
    {
      Name = "timing-public"
    }
  )
  private_route_table_tags = merge(
    var.commontags,
    {
      Name = "timing-private"
    }
  ) */
}