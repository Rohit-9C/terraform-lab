terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

module "container1" {
  source = "./modules/nginx_container"

  container_name = "nginx1"
  container_port = 8081
}

module "container2" {
  source = "./modules/nginx_container"

  container_name = "nginx2"
  container_port = 8082
}
