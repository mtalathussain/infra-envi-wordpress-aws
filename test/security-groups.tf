
resource "aws_security_group" "sg1" {
  name = "sg1-tcp"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]   # keep this 0.0.0.0/0
  }
  tags = {
    Name = "sg1-tcp"
  }
}

resource "aws_security_group" "sg2-ftp" {
  name = "sg2-ftp"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 20
    to_port   = 21
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]     # keep this at 0.0.0.0/0
  }
  tags = {
    Name = "sg2-ftp"
  }
}