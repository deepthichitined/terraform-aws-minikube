variable "cidrblockofvpc" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "project_name" {
    type = string
    default = "roboshop"
}

variable "public_subnets_cidr" {
    type = list 
    default = ["10.0.1.0/24","10.0.2.0/24"]
  
}

variable "private_subnets_cidr" {
    type = list 
    default = ["10.0.11.0/24","10.0.12.0/24"]
  
}

variable "database_subnets_cidr" {
    type = list 
    default = ["10.0.21.0/24","10.0.22.0/24"]
  
}

variable "commontags" {
    type = map 
    default = {
        Name = "roboshop"
        Terraform =true
        Environment = "DEV"
    }  
}

variable "key_name" {
  default = "kubernetes"
}

variable "key_location" {
  default = "C:\\Users\\user\\kubernetes.pub"
}

variable "hosted_zone" {
  default = "techietrainers.com"
}