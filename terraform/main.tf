provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "youtube_app" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  key_name      = "your-key-pair"

  tags = {
    Name = "Youtube-App"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io docker-compose
    systemctl start docker
  EOF
}

output "public_ip" {
  value = aws_instance.youtube_app.public_ip
}
