variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "region" {
  type = string
}


variable "env" {
  type = string

}

variable "app_name" {
  type = string

}

variable "vpc_cidr_block" {
  type = string

}

variable "subnet_zone_a" {
  type = string

}
variable "subnet_zone_b" {
  type = string

}

variable "public_subnet_cidr_a" {
  type = string

}

variable "public_subnet_cidr_b" {
  type = string

}

variable "private_subnet_cidr_a" {
  type = string

}

variable "private_subnet_cidr_b" {
  type = string

}

variable "postgres_db_id" {
  type = string
}

variable "postgres_user_name" {
  type = string
}

variable "postgres_user_password" {
  type = string
}

variable "postgres_db_name" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}



