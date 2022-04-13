variable "ecr_name" {
  default = "workhub"
}

variable "cluster_name" {
  default = "Workhub-Staging"
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

###########Provider###########
provider "aws" {
    alias = "ecr"
    region = "us-east-1"
}
provider "aws" {
  region = var.region
}
###########Provider###########