resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform"
  public_key = file(var.PUBKEY)
}