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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf+Q81u+ChYTl1Dj/cxe1lnlDP8mA3FMvQKM66eu0ATkr41WK5djvHivGwm+0Fb3TKDbURSr/YdBqLzVG9Jpb72wnqvVra0LkYvrCI4XC$"
  }
  resource "aws_instance" "instance-1" {
      ami = "ami-09e2d756e7d78558d"
      instance_type = "t2.micro"
      subnet_id = var.subnet_id
      vpc_security_group_ids =[aws_security_group.ssh-allowed.id]
      key_name = aws_key_pair.developer.id
      count = 1
     tags = {
       Name = "prod instance"
  }
   provisioner "remote-exec" {
    inline [
       echo "build ssh connection to run playbook"
     ]
  connection {
     host = self.public_ip
     type = "ssh"
     user = "ec2-user"
     private_key = file("./developer")
  }
  }
  }
