# Creating a Security Group to login into linux vms
# To access webserver
# So need to create port 22 and 80 open to internet(0.0.0.0/0)
resource "aws_security_group" "tf_sg_new" {
  name        = "${var.env_prefix}-sg"
  description = "Allow SSH and HTTP from the internet"
  vpc_id = var.vpc_id
  ingress  {
    description = "Allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.public_ip]
  }
  ingress  {
    description = "Allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.public_ip]
  }
    ingress  {
    description = "Allow 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [var.public_ip]
  }
  # in console, there is no need to create egress/outbound explicitly
  # but in terraform we need to mention the outbound as well
  egress {
    description = "Allow all ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.public_ip]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "${var.env_prefix}-sg"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "my-new-server-key"
  # public_key = file("id_rsa.pub")
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
  subnet_id = var.subnet-id
  vpc_security_group_ids = [aws_security_group.tf_sg_new.id]
  associate_public_ip_address = true
  user_data = file("entry.sh")

  # Local Exec 
  provisioner "local-exec" {
    # this will be created locally, not on the remote resource created by terraform 
    command = "echo ${self.public_ip} > outputssssssssss.txt"
  }
  tags = {
    "Name" = "${var.env_prefix}"
  }
}
