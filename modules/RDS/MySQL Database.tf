resource "aws_db_instance" "news" {

  identifier = "${var.project_name}-mysql"

  engine = "mysql"

  engine_version = "8.0"

  instance_class = var.db_instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp3"

  db_name = var.db_name

  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.news.name

  vpc_security_group_ids = [
    var.rds_security_group_id
  ]

  publicly_accessible = false

  multi_az = false

  skip_final_snapshot = true

  deletion_protection = false

  backup_retention_period = 7
           
  backup_window           = "03:00-04:00" # UTC time window for daily backups
  maintenance_window      = "Sun:04:30-Sun:05:30"

  storage_encrypted = true

  tags = {
    Name = "${var.project_name}-mysql"
  }

}