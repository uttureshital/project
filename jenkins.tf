provider "aws" {
  region = "eu-west-1" 
}

resource "aws_instance" "jenkins_instance" {
  ami           = "ami-0905a3c97561e0b69" 
  instance_type = "t2.micro"              
  tags = {
    Name = "jenkins-server"
  }

  key_name = "key" 

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y openjdk-11-jdk
              sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
              sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
              sudo apt update
              sudo apt install -y jenkins
              sudo systemctl start jenkins
              EOF
}

output "public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}
