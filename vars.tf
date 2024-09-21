variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "EC2AMI" {
  type = map(string)
  default = {
    eu-west-2 = "ami-0790d22bc8220b7ff"
  }
}

variable "UBUAMI" {
  type = map(string)
  default = {
    eu-west-2 = "ami-07d20571c32ba6cdc"
  }
}

variable "PUBKEY" {
  default = "terraform.pub"
}

variable "PVTKEY" {
  default = "terraform"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MQUSER" {
  default = "rabbit"
}

variable "MQPASS" {
  default = "admin123aditya"
}

variable "DBPASS" {
  default = "admin123"
}

variable "DBUSER" {
  default = "admin"
}

variable "DBNAME" {
  default = "accounts"
}

variable "INSTANCE_COUNT" {
  default = "1"
}

variable "VPC_NAME" {
  default = "aditya-vpc"
}

variable "ZONE1" {
  default = "eu-west-2a"
}

variable "ZONE2" {
  default = "eu-west-2b"
}

variable "ZONE3" {
  default = "eu-west-2c"
}

variable "VPC-CIDR" {
  default = "10.0.0.0/16"
}

variable "PUBSUB1CIDR" {
  default = "10.0.1.0/24"
}

variable "PUBSUB2CIDR" {
  default = "10.0.2.0/24"
}

variable "PUBSUB3CIDR" {
  default = "10.0.3.0/24"
}

variable "PVTSUB1CIDR" {
  default = "10.0.4.0/24"
}

variable "PVTSUB2CIDR" {
  default = "10.0.5.0/24"
}

variable "PVTSUB3CIDR" {
  default = "10.0.6.0/24"
}









