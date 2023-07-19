resource "aws_key_pair" "kubernetes" {
  key_name   = var.key_name
  public_key = file(var.key_location)
}

resource "aws_security_group" "allow_tls" {
  name        = "allow-tls"
  description = "Allow all ports"
  vpc_id      = local.vpc_id 

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

resource "aws_instance" "workstation" {
  ami           = data.aws_ami.ami_id.id
  instance_type = "t3.medium"
   root_block_device  {
      volume_size = 20
    }
  key_name = aws_key_pair.kubernetes.key_name
  security_groups = [aws_security_group.allow_tls.id]
  user_data = "${file("scripts/docker.sh")}"
  subnet_id = local.public_subnet_ids[0]
  associate_public_ip_address = true
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