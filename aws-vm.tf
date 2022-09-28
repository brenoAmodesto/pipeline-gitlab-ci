resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file(var.aws_pub_key)

}

resource "aws_instance" "vm" {
  ami                         = "ami-08ae71fd7f1449df1" # us-west-2
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform"
  }
}

