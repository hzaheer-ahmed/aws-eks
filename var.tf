variable "ecr_name" {
  default = "workhub"
}

variable "cluster_name" {
  default = "workhub-staging"
}

variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}

variable "cluster_version" {
  default = "1.22"
}

data "aws_availability_zones" "available" {}

variable "domain_name" {
  default = "katp.cloud"
}
###########RDS###############
variable "name" {
  default = "workhub-staging"
}

variable "db_psw" {
  default = "Rds#admin=55"
}

variable "db_name" {
  default = "wordpressdb"
}

variable "username" {
  default = "tecadmin"
}

variable "port" {
  default = "3306"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "8.0.25"
}

variable "instance_class" {
  default = "db.t3.small"
}

variable "allocated_storage" {
  default = 10
}
###########Provider###########
provider "aws" {
  alias  = "ecr"
  region = "us-east-1"
}
provider "aws" {
  region = var.region
}
###########Provider############
locals {
  name            = "ex-${replace(basename(path.cwd), "_", "-")}"
  cluster_version = var.cluster_version
  region          = var.region

  tags = {
    Example    = var.cluster_name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}
####################
locals {
  vpc_name = var.name
}
###########redis###############
variable "redis_name" {
  default = "workhub-staging"
}
variable "node_type" {
  default = "cache.t2.small"
}
variable "num_cache_nodes" {
  default = 1
}
variable "redis_engine_version" {
  default = "6.x"
}
###########s3###############
variable "s3-name" {
  default = "workhubinstantconnect"
}
#######Grafana#######
variable "grafana_user" {
  default = "admin"
}
variable "grafana_pwd" {
  default = "Test123"
}