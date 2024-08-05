variable "location" {
  description = "Localização dos recursos"
  type        = string
  default     = "East US"
}

variable "usuario_bd_zabbix" {
  description = "Usuário do Banco de Dados"
  type        = string
  default     = "zabbix"
}

variable "senha_bd_zabbix" {
  description = "Senha do Banco de Dados"
  type        = string
  default     = "zabbixzabbix"
}

variable "server_bd_zabbix" {
  description = "IP ou Host do Zabbix Server"
  type        = string
  default     = "localhost"

}

variable "nome_bd_zabbix" {
  description = "Nome do Banco de Dados"
  type        = string
  default     = "zabbix"
}

