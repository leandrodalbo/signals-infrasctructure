variable "env" {
  type = string

}
variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr_a" {
  type = string
}

variable "public_subnet_zone_a" {
  type = string
}


variable "public_subnet_cidr_b" {
  type = string
}

variable "public_subnet_zone_b" {
  type = string
}

variable "public_subnet_cidr_c" {
  type = string
}

variable "public_subnet_zone_c" {
  type = string
}

variable "private_subnet_cidr_a" {
  type = string
}

variable "private_subnet_zone_a" {
  type = string
}


variable "private_subnet_cidr_b" {
  type = string
}

variable "private_subnet_zone_b" {
  type = string
}

variable "private_subnet_cidr_c" {
  type = string
}

variable "private_subnet_zone_c" {
  type = string
}

variable "private_ip_gw" {
  type = string
}

variable "state_bucket" {
  type = string
}

variable "state_bucket_key" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_service_memory" {
  type = string
}

variable "ecs_image_url" {
  type = string
}

variable "spring_profile_active" {
  type = string
}

variable "docker_container_port" {
  type = number
}

variable "task_number" {
  type = number
}



