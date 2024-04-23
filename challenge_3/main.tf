# main  implicit asociation

resource "aws_key_pair" "citadel-key" {
  key_name   = "citadel"
  public_key = file(".ssh/ec2-connect-key.pub")
}

resource "aws_eip" "eip" {
  instance = aws_instance.citadel.id
  vpc      = true
  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> ~/citadel_public_dns.txt"
  }
}

resource "aws_instance" "citadel" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
  key_name = aws_key_pair.citadel-key.key_name
  user_data     = file("./install-nginx.sh")
}
