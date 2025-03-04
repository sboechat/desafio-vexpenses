variable "projeto" {
  description = "Projetando meu futuro com a VExpenses"
  type        = string
  default     = "VExpenses"
}

variable "candidato" {
  description = "Samuel Ribeiro Boechat Soares"
  type        = string
  default     = "SamuelRibeiroBoechatSoares"
}

variable "aws_region" {
  description = "Região da AWS"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Bloco CIDR da Subnet"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "AMI ID da instância EC2"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  default     = "t2.micro"
}

variable "allowed_ssh_cidr" {
  description = "Faixa de IP permitida para SSH"
  default     = "123.456.789.101/24" // IP específico do desenvolvedor imaginário.
}

variable "igw_cidr" {
  description = "Faixa de IP permitida na route table"
  default = "0.0.0.0/0"
}
