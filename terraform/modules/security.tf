resource "aws_key_pair" "KEYMaker" {
  key_name   = "KEYMaker"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAgNfwxRTtyLJIOIQFeCJv+aAE/tNcMHldoVuvclmAqhJrz/eqhaaLt/jJt1cu9d/8P6GWnJN1mXs1HZmd6WiHmy4vyhhAzXjz8ADVXX4O47qZ5UY/Ld9euwSL3V95daItYm8S9/QH3Q/DAmwUf15fUrfkUdv8cNkKEkdc8AwtYssbR/UbhpTlt/p+Q8rco4KBupYs1SlQd4VnYbfCB62KAqh7Eqg31+O6/w5TBjfmucT83MnHxCn53jpf6XS0f2mbjNE4o//zDYGIp3R0iU/uNTjl9/b2sLqEtj6XmJFix+eZBeusfE5k6Q9nz5wlxnGYKb0DDl11+fw3smBGwCp+LpYxaCgBi3IQKwpMgvZMew8fT2wuIaanX9a+UpOwXUxDEzVKRf2eqxocv0dxcnZxBG7wyMEzGiozLQSpWDjSG92c6fNUbaf7By9NyzHsur+svzRTpUuRKNopr7znPVQ0JtIlFyYG0BiYsseeaILsoLNIlGOIL7QIT30Sc7NAsoTgjiIYK2X8v38Ql3e4UHEP8YOynSTACvppw5SUGzxEj2G58CB8OsADjv0k+5y/j2RNDwoB/2BhJJtGc4Gx5BRIOXt2RMfdKknkpbepKfnOlB1lCsTrEJPgs1t5r6G0gcvv4xz5gl7lnrzVOGEZ+UkrD28mxHEHbSU8GmHW5hKZwTM="
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
