resource "aws_key_pair" "ssh-key" {
  key_name = "docker-server-key"
  public_key = var.public_key_data
  # in the variables, i will be defining the key 
  # public_key = file("id_rsa.pub")
}


# Create a Ec2 Machine with custom subnet in the vpc created
resource "aws_instance" "tf_ec2" {
  ami = "ami-0f34c5ae932e6f0e4"
  instance_type = var.instance_type
  #key_name = "terraform-key"
  key_name = aws_key_pair.ssh-key.key_name
  #count = var.instance_count
  # Want this EC2 in the subnet we created
  subnet_id = aws_subnet.tf_public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.tf_sg_new.id]
  #user_data
  # 2 ways, 1) Script 2) functions
  /*
  user_data = <<-EOF
  #! /bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo service httpd start
  systemctl enable httpd
  echo "<h1> Terraform depends_on </h1>" > /var/www/html/index.html
  EOF 
  */

  user_data = file("entry.sh")
  # chmod +x script.sh
  tags = {
    "Name" = "${var.env_prefix}-docker"
  }
}


output "public_ip" {
  value = aws_instance.tf_ec2.public_ip
}