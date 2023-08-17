resource "aws_key_pair" "ssh-key" {
  key_name = "my-new-server-key"
  public_key = file("id_rsa.pub")
  #public_key = var.public_key_data
  # in the variables, i will be defining the key 
  # public_key = file("id_rsa.pub")
}


# Create a Ec2 Machine with custom subnet in the vpc created
resource "aws_instance" "tf_ec2" {
  ami = "ami-0f34c5ae932e6f0e4"
  instance_type = var.instance_type
  #key_name = "terraform-key"
  key_name = aws_key_pair.ssh-key.key_name
  subnet_id = aws_subnet.tf_public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.tf_sg_new.id]
  associate_public_ip_address = true
  connection {
    type = "ssh" # winrm
    host = self.public_ip # 35.23.34.56
    user = "ec2-user"
    #private_key = var.private_key_location
    private_key = file("id_rsa") # /Users/devopswithcloud/.ssh/id_rsa
  }

  # File Provisioner
  provisioner "file" {
    source = "entry.sh"
    destination = "/home/ec2-user/entry-script.sh"
  }

  # Remote Exec
  provisioner "remote-exec" {
    #script = file("/home/ec2-user/entry-script.sh")
    inline = [ 
      "export VAR=new",
      "mkdir terradir",
      "sh entry-script.sh"
     ]
  }

  # Local Exec 
  provisioner "local-exec" {
    # this will be created locally, not on the remote resource created by terraform 
    command = "echo ${self.public_ip} > outputssssssssss.txt"
  }
  tags = {
    "Name" = "i27-${terraform.workspace}"
  }
}


output "public_ip" {
  value = aws_instance.tf_ec2.public_ip
}