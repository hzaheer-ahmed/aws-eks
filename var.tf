variable "cluster_name" {
  default = "Workhub-Staging"
}

variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

variable "cluster_version" {
  default = "1.22"
}

data "aws_availability_zones" "available" {}

variable "domain_name" {
  default = "katp.cloud"
}