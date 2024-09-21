resource "aws_instance" "aditya-bastion" {
  instance_type = ""
  ami = var.UBUAMI[var.AWS_REGION]
  key_name = aws_key_pair.terraform-key.key_name
  vpc_security_group_ids = [aws_security_group.aditya-bastion-sg.id]
  subnet_id = module.vpc.public_subnets[0]
  count = var.INSTANCE_COUNT
  tags = {
    Name = "Aditya-bastion"
  }

  provisioner "file" {
    content = templatefile("templates/db-deploy.tmpl", { RDS-ENDPOINT = aws_db_instance.aditya-rds.address, DBUSER = var.DBUSER, DBPASS = var.DBPASS } )
    destination = "/tmp/deploy.sh"
    #takes the content of db-deploy.tmpl template adds the values to the variable and stores it as deploy.sh in bastion host in /tmp/file next is to execute it
  }

  provisioner "remote-exec" {
    inline = [
    "chmod +x /tmp/deploy.sh",
      "sudo /tmp/deploy.sh"
    ]
  }

  connection {
    user = var.USERNAME
    private_key = file(var.PVTKEY)
    host = self.public_ip
  }

  depends_on = [aws_db_instance.aditya-rds]
}