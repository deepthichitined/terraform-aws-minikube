resource "aws_key_pair" "provisioner" {
  key_name   = "provisioner"
  public_key = file("C:\\Users\\manid\\provisioner.pub")
}

resource "aws_security_group" "allow_tls" {
  name        = "allow-tls"
  description = "Allow all ports"
  vpc_id      = "vpc-0cfe2936d836cb8dc" #default vpc id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "ec2instance" {
  ami           = "ami-090e0fc566929d98b"
  instance_type = "t3.micro"
  key_name = aws_key_pair.provisioner.key_name
  security_groups = [aws_security_group.allow_tls.name]
  user_data = "${file("scripts/docker.sh")}"
  tags = {
    Name = "provisioner"
  }

  
 provisioner "local-exec" {
    command = "echo the server ip is ${self.public_ip} > public_ip.txt"
  }
}

/* 
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0cfe2936d836cb8dc"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

  resource "aws_instance" "remoteinstance" {
  ami           = "ami-090e0fc566929d98b"
  instance_type = "t3.micro"
  key_name = aws_key_pair.provisioner.key_name
  security_groups = [aws_security_group.allow_tls.name]
  tags = {
    Name = "remote-provisioner"
  }

  
connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:\\Users\\manid\\provisioner.pem")
    host     = self.public_ip
  }

   provisioner "remote-exec" {
    script = "scripts/docker.sh"
  }
  
 provisioner "remote-exec" {
    inline = [
      "touch /tmp/remote.txt",
      "echo 'this file is created by remote provisioner' > /tmp/remote.txt",
    ]
  }
} */