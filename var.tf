variable "cluster_name" {
  default = "graphana-test"
}

variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}