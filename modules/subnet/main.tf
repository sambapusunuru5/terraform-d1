# All the value that are set here should be set by variables.
# Create a subnet to the vpc in step 1
resource "aws_subnet" "tf_public_subnet_1" {
  cidr_block = var.subnet_cidr_blocks #"10.1.1.0/24" 
  vpc_id = var.vpc_id
  #vpc_id = aws_vpc.tf_vpc_new.id
  availability_zone = var.availability_zone #"us-east-1a"
  map_public_ip_on_launch = true #false
  tags = {
    "Name" = "${var.env_prefix}-public-subnet-1"
  }
}

# Creating a igw in my custom vpc
resource "aws_internet_gateway" "tf_vpc_igw" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "tf-main-rtb" {
  default_route_table_id = var.default_route_table_id
  #default_route_table_id = aws_vpc.tf_vpc_new.default_route_table_id
  route {
    cidr_block = var.public_ip
    gateway_id = aws_internet_gateway.tf_vpc_igw.id
  }
  tags = {
    "Name" = "${var.env_prefix}-main-rtb"
  }
}