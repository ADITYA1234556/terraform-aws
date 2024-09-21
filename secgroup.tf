resource "aws_security_group" "aditya-bastion-sg" {
  name        = "aditya-bastion-sg"
  description = "security group for bastion ec2 instance"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my-tf-sg-elb" {
  name        = "aditya-vpc-sg-elb"
  description = "My sg created for elb usign Terraform"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aditya-vpc-sg" {
  name        = "aditya-vpc-sg"
  description = "My sg created usign Terraform"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.aditya-bastion-sg.id]
  }
}

resource "aws_security_group" "aditya-backend-sg" {
  name        = "aditya-backend-sg"
  description = "Security group for backgroup services RDS, ACTIVE MQ, ELASICCACHE"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.aditya-vpc-sg.id, aws_security_group.aditya-bastion-sg.id]
  }
}

resource "aws_security_group_rule" "sec_group_allow_internal_traffic" {
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.aditya-backend-sg.id
  source_security_group_id = aws_security_group.aditya-backend-sg.id
  to_port                  = 65535
  type                     = "ingress"
}