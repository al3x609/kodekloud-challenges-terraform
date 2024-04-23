
# main 
resource "aws_key_pair" "citadel-key" {
  key_name   = "citadel"
  public_key = file(".ssh/ec2-connect-key.pub")
}

resource "aws_eip" "eip" {
  vpc = true
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
  associate_public_ip_address = true
  depends_on = [aws_eip.eip]
  user_data     = file("./install-nginx.sh")
}

# Asociar la Elastic IP a la instancia
resource "aws_eip_association" "eip_asociacion" {
  instance_id   = aws_instance.citadel.id
  allocation_id = aws_eip.eip.id
}
