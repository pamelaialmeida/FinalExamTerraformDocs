resource "aws_instance" "web1" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Production_Env1"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
        command = "chmod +x ./getkey.sh && ./getkey.sh prod1envkey"
  }

  provisioner "remote-exec" {
          inline = [
                "chmod 700 ~/.ssh",
                "chmod 600 ~/.ssh/authorized_keys",
                "sudo yum install -y httpd",
                "sudo systemctl start httpd",
                "sudo systemctl enable httpd",
                "sudo chmod 777 /var/www/html"
          ]
 }
}

resource "aws_instance" "web2" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Production_Env2"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
        command = "chmod +x ./getkey.sh && ./getkey.sh prod2envkey"
  }

  provisioner "remote-exec" {
          inline = [
                "chmod 700 ~/.ssh",
                "chmod 600 ~/.ssh/authorized_keys",
                "sudo yum install -y httpd",
                "sudo systemctl start httpd",
                "sudo systemctl enable httpd",
                "sudo chmod 777 /var/www/html"
         ]
  }
}

resource "aws_instance" "web3_testing_env" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Testing_Env"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
        command = "chmod +x ./getkey.sh && ./getkey.sh testingkey"
  }

  provisioner "remote-exec" {
          inline = [
                "chmod 700 ~/.ssh",
                "chmod 600 ~/.ssh/authorized_keys",
                "sudo yum install -y httpd",
                "sudo systemctl start httpd",
                "sudo systemctl enable httpd",
                "sudo chmod 777 /var/www/html"
          ]
  }
}

resource "aws_instance" "web4_staging_env" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.secret_key.key_name
  tags = {
    Name = "Staging_Env"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.jkey.private_key_pem
  }

  provisioner "local-exec" {
        command = "chmod +x ./getkey.sh && ./getkey.sh stagingkey"
  }

  provisioner "remote-exec" {
          inline = [
                "chmod 700 ~/.ssh",
                "chmod 600 ~/.ssh/authorized_keys",
                "sudo yum install -y httpd",
                "sudo systemctl start httpd",
                "sudo systemctl enable httpd",
                "sudo chmod 777 /var/www/html"
          ]
  }
}

output "prod1_env_ip" {
  value = aws_instance.web1.public_ip
}

output "prod2_env_ip" {
  value = aws_instance.web2.public_ip
}

output "testing_env_ip" {
  value = aws_instance.web3_testing_env.public_ip
}

output "staging_env_ip" {
  value = aws_instance.web4_staging_env.public_ip
}
