module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.s3-name
  acl    = "private"

  versioning = {
    enabled = true
  }

}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis_name
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = "default.redis6.x"
  #engine_version       = var.redis_engine_version
  port = 6379

}