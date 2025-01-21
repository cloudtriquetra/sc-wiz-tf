resource "aws_db_parameter_group" "postgresql" {
  name        = "custom-postgresql-parameter-group"
  family      = "postgres12"
  description = "Custom parameter group for PostgreSQL"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
}

data "aws_kms_key" "rds" {
  key_id = "alias/rds/test"
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "12.5"
  instance_class       = "db.t2.micro"
  #name                 = "exampledb"
  username             = "admin"
  password             = "password"
  parameter_group_name = aws_db_parameter_group.postgresql.name
  skip_final_snapshot  = true
  kms_key_id = data.aws_kms_key.rds.arn

  tags = {
    Name = "example-postgres-instance"
  }
}

