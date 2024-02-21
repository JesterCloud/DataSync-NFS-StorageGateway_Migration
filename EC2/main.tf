# EC2/Main --------------------------------------
data "aws_ami" "serverNFS" {
  filter {
    name   = "image-id"
    values = ["ami-0440d3b780d96b29d"]
  }
}

resource "aws_iam_instance_profile" "ec2_profile" { # En Terraform primero hay que CREAR EL INSTANCE PROFILE para despues llamarlo
  name = "EC2Full-Profile"
  role = "EC2Full" # Aqui va el nombre del ROLE, es mucho mas facil asi!!! +++++
}

resource "aws_instance" "linux_server_nfs" {
  ami                    = data.aws_ami.serverNFS.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.NFSServerSG]
  subnet_id              = var.subnet_idNFS
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name # Es mas facil llamando el role por nombre arriba, liego aqui: var.iam_instance_profile_arn (con variable y luego outputs)

  root_block_device {
    volume_size = var.volume_size
  }

  user_data = templatefile("${path.module}/setup-nfs.tpl", {}) # ${path.root} si se encuentra en el ROOT


  tags = {
    Name = "Linux Server NFS"
  }
}
