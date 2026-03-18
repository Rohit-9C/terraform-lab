erraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

variable "container_config" {
  description = "List of containers"
  type = list(object({
    name = string
    port = number
  }))

  default = [
    { name = "web1", port = 8081 },
    { name = "web2", port = 8082 },
    { name = "web3", port = 8083 }
  ]
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "containers" {
  for_each = {
    for container in var.container_config :
    container.name => container
  }

  name  = each.value.name
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = each.value.port
  }
}

output "container_urls" {
  value = [
    for container in var.container_config :
    "http://localhost:${container.port}"
  ]
}
