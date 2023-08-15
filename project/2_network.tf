# Creating a vpc
resource "aws_vpc" "tf_vpc_new" {
    //argument 
  cidr_block = var.vpc_cidr_blocks
  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

# Create a subnet to the vpc in step 1
resource "aws_subnet" "tf_public_subnet_1" {
  cidr_block = var.subnet_cidr_blocks #"10.1.1.0/24" 
  vpc_id = aws_vpc.tf_vpc_new.id
  availability_zone = var.availability_zone #"us-east-1a"
  map_public_ip_on_launch = true #false
  tags = {
    "Name" = "${var.env_prefix}-public-subnet-1"
  }
}

# Creating a igw in my custom vpc
resource "aws_internet_gateway" "tf_vpc_igw" {
  vpc_id = aws_vpc.tf_vpc_new.id
  tags = {
    "Name" = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "tf-main-rtb" {
  default_route_table_id = aws_vpc.tf_vpc_new.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_vpc_igw.id
  }
  tags = {
    "Name" = "${var.env_prefix}-main-rtb"
  }
}
/*
# Creating the RT(Route table) in custom 
resource "aws_route_table" "tf_rt_public" {
  vpc_id = aws_vpc.tf_vpc_new.id
}

# We need to create a route, in the RT to get internet
# we need to explicitlyy mention the IGW 
resource "aws_route" "name" {
  route_table_id = aws_route_table.tf_rt_public.id
  gateway_id = aws_internet_gateway.tf_vpc_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Map/associate the subnet created with Route Table
resource "aws_route_table_association" "tf_rt_pub_asso" {
  route_table_id = aws_route_table.tf_rt_public.id
  subnet_id = aws_subnet.tf_public_subnet_1.id
}
*/

# Creating a Security Group to login into linux vms
# To access webserver
# So need to create port 22 and 80 open to internet(0.0.0.0/0)
resource "aws_security_group" "tf_sg_new" {
  name        = "production-vpc-sg"
  description = "Allow SSH and HTTP from the internet"
  vpc_id = aws_vpc.tf_vpc_new.id
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