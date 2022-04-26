

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "baston"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCw8DkUYU1IxQyjXckZZvdRT07kF+VXCnYilpRlER0EuHNWoVPwq/hg4WI+5on42ojdEGgJElgPwzuUllD8gOP4yCw/akLJPbG+RMw1Z0cbbyCwgy+HCQRcuIblX9BJmijSNKOgk70KN5gyh6Gsg/YAoGG6unCJEwSa8WpZOOJ5FWHL9EtChx79bfO7dSBtZWRQacnffZs7I4TkyNXUW+WGvjEnw+2MDeTbPVqOPo3by3GB8Tp8rF1wdenzHDHNGhxtNcBlOL7n/5XVTXnnkspzUN9+HjgxeSXVjW7U89q5EAo+Zhq+p8SsLuJeIL8ZcLVnt0hSBFXSgk8H1UTcPt6rQmDyJNWFHwBuyFOCMmAt+rYVmhFPFOZUZY3pz6oS6Vp00e7TOQk3v0oKqdwq67Dpfq6NIjq7Oykjo1vqBFsXOF/8hTErk+EjRDpVxKr1aKcT1QbRynVfKDxwceUGI29ag+eFGzERmdOEWiLQQlyI93OlIImCdL6hEuV12Z8y4D0= root@DESKTOP-PALJ7OT"

}

module "ec2_instance" {
  depends_on = [
    module.key_pair,
    aws_security_group.remote_access
  ]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Staging-Bastion"

  ami                    = "ami-0f03c77be69621426"
  instance_type          = "t2.micro"
  key_name               = "baston"
  vpc_security_group_ids = [aws_security_group.remote_access.id]
  monitoring             = true
  subnet_id              = tolist(module.vpc.public_subnets)[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}