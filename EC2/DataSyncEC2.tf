data "aws_ami" "DataSync_EC2" {
  filter {
    name   = "image-id"
    values = ["ami-073c509a30ffe8eaa"]
  }
}

resource "aws_iam_instance_profile" "DataS_Profile" {
  name = "EC2Full-Profile-datasync"
  role = "EC2Full"
}

resource "aws_instance" "DataSync_Agent" {
  ami                         = data.aws_ami.DataSync_EC2.id
  instance_type               = "t3.xlarge"
  vpc_security_group_ids      = ["sg-0785860525d735236"] #
  subnet_id                   = "subnet-08426bd95ac6e76de" #
  iam_instance_profile        = aws_iam_instance_profile.DataS_Profile.id
  associate_public_ip_address = true


  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "DataSyncAgent"
  }

}