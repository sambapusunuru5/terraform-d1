# Creation of AWS resource

# Create a vpc in us-east-1
resource "aws_vpc" "tf_main_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name" = "main VPC"
  }
}


# Multi provider block

# Create a vpc in us-west-1
resource "aws_vpc" "tf_vpc_new" {
  cidr_block = "10.2.0.0/16"
  tags = {
    "Name" = "New VPC"
  }
  provider = aws.aws-west-1 
  # Meta arguments 
}



