resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "${var.PROJECT}-db-subnet-group-${var.ENV}"
  subnet_ids = var.DB_SUBNETS

  tags = {
    Environment = var.ENV
    Name        = "${var.PROJECT}-db-subnet-group-${var.ENV}"
  }
}

resource "aws_db_parameter_group" "db-parameter-group" {
  name   = "${var.PROJECT}-db-parameter-group-${var.ENV}"
  family = var.DB_FAMILY

  tags = {
    Environment = var.ENV
    Name        = "${var.PROJECT}-db-parameter-group-${var.ENV}"
  }
}

resource "aws_db_instance" "db" {
  storage_type      = var.DB_STORAGE_TYPE
  allocated_storage = var.DB_ALLOCATED_STORAGE
  instance_class    = var.DB_INSTANCE_CLASS
  engine            = var.DB_ENGINE
  engine_version    = var.DB_ENGINE_VERSION
  identifier        = "${var.PROJECT}-db-${var.ENV}"

  db_name  = var.DB_NAME
  port     = var.DB_PORT
  username = var.DB_USERNAME
  password = var.DB_PASSWORD

  multi_az                = var.DB_MULTI_AZ
  availability_zone       = var.DB_AVAILABILITY_ZONE
  backup_retention_period = var.DB_BACKUP_RETENTION_PERIOD
  skip_final_snapshot     = var.DB_SKIP_FINAL_SNAPSHOT

  publicly_accessible    = var.DB_PUBLICLY_ACCESSIBLE
  vpc_security_group_ids = var.DB_SECURITY_GROUP_IDS

  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  parameter_group_name = aws_db_parameter_group.db-parameter-group.name

  tags = {
    Environment = var.ENV
    Name        = "${var.PROJECT}-db-${var.ENV}"
  }
}