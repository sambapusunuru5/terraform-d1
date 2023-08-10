/*variable "region" {
  description = "Default region to be considered"
  default = "us-east-1"
  type = string
}
*/

output "ec2_public_ip" {
    description = "Its the Public ip of EC2 machine"
    value = aws_instance.tf_ec2.public_ip
    sensitive = true
}


