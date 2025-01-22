resource "aws_db_parameter_group" "postgresql" {
  name        = "custom-postgresql-parameter-group"
  family      = "postgres16"
  description = "Custom parameter group for PostgreSQL"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
}

data "aws_kms_key" "rds" {
  #key_id = "alias/rds/test"
  key_id = "alias/aws/rds"
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  instance_class       = "db.t3.medium"
  #name                 = "exampledb"
  username             = "dbadmin"
  password             = "password"
  parameter_group_name = aws_db_parameter_group.postgresql.name
  skip_final_snapshot  = true
  kms_key_id = data.aws_kms_key.rds.arn
  storage_encrypted = true

  tags = {
    Name = "example-postgres-instance"
  }
}

