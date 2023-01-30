#########################################
# ECS Cluster
#########################################
module "ecs" {
  source = "registry.terraform.io/terraform-aws-modules/ecs/aws"
  version = "3.5.0"

  name                               = var.cluster_name
  capacity_providers                 = ["FARGATE"]
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
    }
  ]

  tags = {
    owning_team = "CAOS"
  }
}
