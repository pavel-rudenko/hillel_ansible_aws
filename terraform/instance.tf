resource "aws_key_pair" "dev" {
  key_name_prefix = "dev-"
  public_key      = var.key_pair
  tags = {
    "Env" = "Dev"
  }
}
resource "aws_key_pair" "prod" {
  key_name_prefix = "prod-"
  public_key      = var.key_pair
  tags = {
    "Env" = "Prod"
  }
}
resource "aws_instance" "dev" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.dev_and_prod.name]
  key_name        = aws_key_pair.dev.key_name
  tags = {
    "Env" = "Dev"
  }
}
resource "aws_instance" "prod" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.dev_and_prod.name]
  key_name        = aws_key_pair.prod.key_name
  tags = {
    "Env" = "Prod"
  }
}
resource "aws_security_group" "dev_and_prod" {
  name = "dev_and_prod_sg"
  tags = {
    "Env" = "Dev&Prod"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "SSH" {
  description       = "SSH from everywhere"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_and_prod.id
}
resource "aws_security_group_rule" "HTTP" {
  description       = "Allow plain HTTP from anywhere"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dev_and_prod.id
}