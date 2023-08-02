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
  default = "t2-micro"
}

variable "count" {
  description = "number of instances to be created"
  default = 1
  type = number
}


