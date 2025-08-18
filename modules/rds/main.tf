# Create a DB subnet group spanning the private subnets
resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnets"
  subnet_ids = var.private_subnet_ids
}

# Security group for the RDS database
resource "aws_security_group" "db" {
  name   = "${var.project_name}-db-sg"
  vpc_id = var.vpc_id

  # Allow MySQL traffic (port 3306) only from the web security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the RDS MySQL database instance
resource "aws_db_instance" "mysql" {
  identifier             = "${var.project_name}-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  multi_az               = false                 # Single AZ deployment
  publicly_accessible    = false                 # Private only, not internet-exposed
  skip_final_snapshot    = true                  # Delete without final backup
  deletion_protection    = false                 # Allow instance deletion
}