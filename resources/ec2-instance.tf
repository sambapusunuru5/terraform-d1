# Create a resource EC2

resource "aws_instance" "tf_my_ec2" {
  ami = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a" # desired
  tags = {
    "Name" = "Web-Server"
    "env" = "QA"
  }
}