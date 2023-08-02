# Create a Ec2 Machine with custom subnet in the vpc created
resource "aws_instance" "tf_ec2" {
  ami = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1b"
  tags = {
    "Name" = "webserver-1"
  }
}

# other instance 
resource "aws_instance" "tf_ec2_new" {
  ami = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1b"
  tags = {
    "Name" = "webserver-2"
  }
/*  lifecycle {
    prevent_destroy = true
  }*/
}

