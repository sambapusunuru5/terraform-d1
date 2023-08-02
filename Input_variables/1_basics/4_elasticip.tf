# Creating a static ip
resource "aws_eip" "tf_vpc_eip" {
  instance = aws_instance.tf_ec2.id
  vpc = true

  # there should be a dependency when to create elastic ip 
  # it should only be created after the IGW is created
  depends_on = [ 
    aws_internet_gateway.tf_vpc_igw
   ]
}