provider "aws" {
  region = "eu-west-2" 
}

resource "aws_instance" "jenkins_instance" {
  ami           = "ami-0e5f882be1900e43b" 
  instance_type = "t2.micro"              
  tags = {
    Name = "jenkins-instance"
  }

  key_name = "jenkins" 

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
