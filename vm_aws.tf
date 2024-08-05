data "template_file" "install_zabbix_server" {
  template = file("./docs/zabbix_server.sh.tpl")

  vars = {
    USUARIO_BD_ZABBIX = var.usuario_bd_zabbix
    SENHA_BD_ZABBIX   = var.senha_bd_zabbix
    SERVER_BD_ZABBIX  = var.server_bd_zabbix
    NOME_BD_ZABBIX    = var.nome_bd_zabbix
  }
}

resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./keys_ssh/aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-04a81a99f5ec58529"
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true
  user_data                   = data.template_file.install_zabbix_server.rendered

  tags = {
    Name = "vm-terraform"
  }
}


