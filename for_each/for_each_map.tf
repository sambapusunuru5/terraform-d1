resource "aws_s3_bucket" "tf_for_each_bucket" {
  for_each = { # map
    "dev" = "devopswithcloud-siva-aws"
    "uat" = "devopswithcloud-siva-aws"
    "prod" = "devopswithcloud-siva-aws"
  }
  bucket = "${each.key}-${each.value}" # dev-devopswithcloud-siva-aws
  #uat-devopswithcloud-siva-aws
  #prod-devopswithcloud-siva-aws
  tags = {
    Env = each.key
    myvalue = each.value
    Name = "${each.key}-${each.value}"
  }
}



