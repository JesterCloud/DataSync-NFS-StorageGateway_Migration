# EC2/Main --------------------------------------
data "aws_ami" "serverNFS" {
  filter {
    name   = "image-id"
    values = ["ami-123123123"] # Need to update to a real AMI
  }
}

resource "aws_iam_instance_profile" "ec2_profile" { # Create Instance Profile
  name = "EC2Full-Profile"
  role = "EC2Full"
}

resource "aws_instance" "linux_server_nfs" {
  ami                    = data.aws_ami.serverNFS.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.NFSServerSG]
  subnet_id              = var.subnet_idNFS
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_size = var.volume_size
  }

  user_data = templatefile("${path.module}/setup-nfs.tpl", {}) # ${path.root} si se encuentra en el ROOT


  tags = {
    Name = "Linux Server NFS"
  }
}
