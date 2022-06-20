resource "aws_eip" "MKREIP" {
  instance = aws_instance.MakerSVR.id
  vpc = true
  
  tags = {
    Name = "MakerIP"
  }
}

resource "aws_instance" "MakerSVR" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.small"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.KEYMaker.key_name
  depends_on                  = ["aws_internet_gateway.main"]
  vpc_security_group_ids      = [aws_security_group.ghostsg.id]
  subnet_id					  = aws_subnet.main.id
  
  user_data = <<-EOF
    #!/bin/bash
    echo "test of user_data" | sudo tee /tmp/user_data.log
    curl http://169.254.169.254/latest/meta-data/local-ipv4 | sudo tee -a /tmp/user_data.log
  EOF

  tags = {
    Name = "MakerSVR"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.MakerSVR.id
  allocation_id = aws_eip.MKREIP.id
}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_eip.MKREIP.public_ip
}