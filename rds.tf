module "db8" {
  depends_on = [
    aws_security_group.mysql
  ]
  source = "terraform-aws-modules/rds/aws"

  identifier = var.name

  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  create_random_password = false

  db_name           = var.db_name
  username          = var.username
  password          = var.db_psw
  availability_zone = "eu-central-1b"


  vpc_security_group_ids = [aws_security_group.mysql.id]

  create_monitoring_role = false

  tags = {
    Owner       = "user"
    Environment = "test"
    name        = var.name
    Terraform   = "true"
  }

  # DB subnet group
  db_subnet_group_name = module.vpc.database_subnet_group_name
  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  #deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

module "db5" {
  depends_on = [
    aws_security_group.mysql
  ]
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.name}-v5-7"

  engine                 = var.engine
  engine_version         = "5.7.33"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  create_random_password = false

  db_name           = var.db_name
  username          = var.username
  password          = var.db_psw
  availability_zone = "eu-central-1b"


  vpc_security_group_ids = [aws_security_group.mysql.id]

  create_monitoring_role = false

  tags = {
    Owner       = "user"
    Environment = "test"
    name        = "${var.name}-57"
    Terraform   = "true"
  }

  # DB subnet group
  db_subnet_group_name = module.vpc.database_subnet_group_name
  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  #deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}