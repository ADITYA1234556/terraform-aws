resource "aws_db_subnet_group" "aditya-rds-subnet" {
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  name       = "aditya-rds-subnet"
  tags = {
    Name = "Subnet group for rds"
  }
}

resource "aws_elasticache_subnet_group" "aditya-elasticache-subgrp" {
  name       = "aditya-elasticache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet group for elasticache"
  }
}

resource "aws_db_instance" "aditya-rds" {
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  db_name                = var.DBNAME
  username               = var.DBUSER
  password               = var.DBPASS
  parameter_group_name   = "default.mysql8.0"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.aditya-rds-subnet.name
  vpc_security_group_ids = [aws_security_group.aditya-backend-sg.id]
}

resource "aws_elasticache_cluster" "aditya-cache" {
  cluster_id           = "aditya-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.aditya-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.aditya-elasticache-subgrp.name
}

resource "aws_mq_broker" "aditya-mq" {
  broker_name        = "aditya-mq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.16.7"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.aditya-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    password = var.MQPASS
    username = var.MQUSER
  }
}