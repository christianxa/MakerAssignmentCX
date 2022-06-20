resource "aws_key_pair" "KEYMaker" {
  key_name   = "KEYMaker"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCVMCbvS7pEKaosFnYzDQytw8DfXq6eZFMAmYC84MJk3ORFsrqaMtciLO/pFSkapkcYxgMBQKU+FfKlKB2CJ/b1LZ6tJIK8aQ6TDduPNccx1MH0apTNi9XJzbGzXsIlIzH16iTcrjvLAVjViosH36ZUI6ODRObXH9Wsrj9njStiHGNs+Uk7v7PXBOaaO3hYqTf+6apVA16+bq7Aao98F2RJ/91jMsQRc2bmlrc2nWbNrv2iVQ2PccA2wfjelxoAjZVv8kPuPyA53IjTlBxEYkIclOx9XtoPnWTMj00nFvly7b+ML3lLE+6k74JaGckCsq9lw3xEjJyfXPoOYtoxs5sjhWW6+PvK1ImNk0Am0p1pDC8VXJX7HE7HBpl1hBn2Etc7+QcshsdIcnbu+3QL/CneNfwD0D0SHFMTRn7Gi5WlP+TcaYrnARDPJE9rcegi+Yw9BAbGRXpz4kv3+K4Ndr97Zcz3FM8ToLOMXkEnCRjedAVzRoxoJCqrkCk/RfnbO68cNvRK5GlXP+FYok8Q3Hby7Fh4nG+bD1ph7aQa5ejagFzuFsCLllvWU6gAVx9Gu1CsmWAweQ0MYIXhqC6U/odkI/x2akGOC/tMr6V3OcuthdDFsav0wGhprT00dvBFEg/kqJv+rVvVGhyEfcO3GU8NXTBgK1TUmQ6aAAkFsU69w=="
}

resource "aws_security_group" "ghostsg" {
  name        = "ghostsg"
  description = "Allow SSH, HTTP(S), Jenkins from Anywhere"
  vpc_id      = aws_vpc.main.id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ghostsg"
  }
}

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main"
  }
}

output "securitygroup_id" {
  value = aws_security_group.ghostsg.id
}
