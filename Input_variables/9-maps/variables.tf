# Define Varibales
variable "region" {
  description = "Default region to be considered"
  default = "us-east-1"
  type = string
}

variable "zone" {
  description = "Default zone to be considered"
  default = "us-east-1a"
  type = string
}

variable "instance_type" {
  description = "Ec2 machine instance type used"
  #type = list(string)
  # default = ["t2.micro", "t2.small"]
  type = map(string)
  default = {
    "devenv" = "t2.small"
    "testenv" = "t2.micro"
    "stageenv" = "t3.medium"
  }
}

variable "instance_count" {
  description = "number of instances to be created"
  default = 1
  type = number
}

variable "ami_id" {
  type = string
  default = "ami-0f34c5ae932e6f0e4"
}

variable "in_tags" {
  description = "this is for ec2 tags"
  type = map(string)
  default = {
    "Name" = "web-app"
    "Engineer" = "Siva"
  }
}