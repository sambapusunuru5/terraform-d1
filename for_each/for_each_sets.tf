

resource "aws_iam_user" "tf_for_each_user" {
  #siva maha
  for_each = toset(["siva", "maha"])
  name = each.key
  # name = each.value
  # arguments 
  # each.key=each.value
}