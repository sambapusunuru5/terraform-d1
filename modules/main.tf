

# Creating a vpc
resource "aws_vpc" "tf_vpc_new" {
    //argument 
  cidr_block = var.vpc_cidr_blocks
  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

module "my-subnet" { # user-friendly name 
  source = "./subnet"
  vpc_id = aws_vpc.tf_vpc_new.id
  #subnet_cidr_blocks = "10.0.10.0/24"
  subnet_cidr_blocks = var.subnet_cidr_blocks
  availability_zone = var.availability_zone
  default_route_table_id = aws_vpc.tf_vpc_new.default_route_table_id
  public_ip = var.public_ip
  env_prefix = var.env_prefix
}


module "my-server" {
  source = "./webserver"
  vpc_id = aws_vpc.tf_vpc_new.id
  public_ip = var.public_ip
  env_prefix = var.env_prefix
  instance_type = var.instance_type
  public_key_data = var.public_key_data
  # The below subnet id should be coming from a different module output.
  subnet-id = module.my-subnet.subnet.id
}
