resource "aws_security_group" "ssh-allowed" {
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
}
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }
}
resource "aws_key_pair" "developer" {
  key_name   = "developer"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf+Q81u+ChYTl1Dj/cxe1lnlDP8mA3FMvQKM66eu0ATkr41WK5djvHivGwm+0Fb3TKDbURSr/YdBqLzVG9Jpb72wnqvVra0LkYvrCI4XCuj6PVAthFtvsNJaGBCtA2l1lXyoGDOD56qSKzBQJ36Patdv8t3eZbRatJyZXwyoQJPMKwX5Ai+3ctxCqOJAssF5EpSNMdF+RzD2TWoFa6iuW2Ak2syYRoK+psZdhS9bzmWAEh22ZiRl4DYmKYvJsuZiAPpAVQIKESItxWsdZ+c/9AM3jMZ98zrV48xEPJcWO597SxEg+cEUdNxT928pqK5EsJDFR1XzYd5BcLwvHpl7m3 ec2-user@ip-172-31-24-225.eu-central-1.compute.internal"
  }
  resource "aws_instance" "instance-1" {
      ami = var.ami_id
      instance_type = var.instance_type
      subnet_id = var.subnet_id
      vpc_security_group_ids =[aws_security_group.ssh-allowed.id]
      key_name = aws_key_pair.developer.id
      count = 1
     tags = {
       Name = "prod instance"
  }
   provisioner "remote-exec" {
    inline = [
       "echo 'build ssh connection to run playbook' "
     ]
  connection {
     host = self.public_ip
     type = "ssh"
     user = "ec2-user"
     private_key = file("./developer")
  }
  }
  provisioner "local-exec"{
  command = "ansible-playbook -i ${aws_instance.instance-1.public_ip}, --private-key ${var.privatekey} play.yml"
  }
  }
