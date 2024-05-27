# Creates security group
resource "aws_security_group" "allows_app" {
  name                      = "roboshop-${var.COMPONENT}-${var.ENV}"
  description               = "roboshop-${var.COMPONENT}-${var.ENV}"

  ingress {
    description              = "SSH from public Network"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
  }

  egress {
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    cidr_blocks              = ["0.0.0.0/0"]
  }

  tags = {
    Name                     = "roboshop-${var.COMPONENT}-${var.ENV}"
  }
}