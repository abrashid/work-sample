resource "aws_security_group" "load_balancers" {
  name        = "load_balancers"
  description = "Allows all traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow port 80"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow port 443"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all ports"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-elb"
    Project     = var.project
    Environment = var.environment
  }
}


output "elb_security_group_id" {
  value = aws_security_group.load_balancers.id
}

