
resource "docker_image" "php-httpd-image" {
  name = "php-httpd:challenge"
  build {
    path = "lamp_stack/php_httpd"

    label = {
      challenge : "second"
    }
  }
}


resource "docker_image" "mariadb-image" {
  name = "mariadb:challenge"
  build {
    path = "lamp_stack/custom_db"

    label = {
      challenge : "second"
    }
  }
}

resource "docker_volume" "mariadb_volume" {
  name = "mariadb-volume"
}

# Start a container
resource "docker_container" "php-httpd" {
  name  = "webserver"
  image = docker_image.php-httpd-image.name
  hostname = "php-httpd"
  ports {
    internal = "80"
    external = "80"
  }
  labels {
    label = "challenge"
    value  = "second"
  }
  volumes {
    container_path = "/var/www/html"
    host_path = "/root/code/terraform-challenges/challenge2/lamp_stack/website_content/"
  }
  networks_advanced  {
    name = docker_network.private_network.name
  }
}



# Start a container
resource "docker_container" "mariadb" {
  name  = "db"
  image = docker_image.mariadb-image.name
  hostname = "db"
  ports {
    internal = "3306"
    external = "3306"
  }
  env = [
    "MYSQL_ROOT_PASSWORD=1234",
    "MYSQL_DATABASE=simple-website"
  ]
  labels {
    label = "challenge"
    value  = "second"
  }
  volumes {
    container_path = "/var/lib/mysql"
    volume_name =  docker_volume.mariadb_volume.name
  }
  networks_advanced  {
    name = docker_network.private_network.name
  }
}


#network
resource "docker_network" "private_network" {   
  name = "my_network"   
  attachable = true   
  labels {     
    label = "challenge"     
    value = "second"   
  } 
}


# Start a container
resource "docker_container" "phpmyadmin" {
  name  = "db_dashboard"
  image = "phpmyadmin/phpmyadmin"
  hostname = "phpmyadmin"
  ports {
    internal = "80"
    external = "8081"
  }
  labels {
    label = "challenge"
    value  = "second"
  }
  depends_on = [
    docker_container.mariadb
  ]
  links = [
    docker_container.mariadb.name
  ]
  volumes {
    container_path = "/var/www/html"
    host_path = "/root/code/terraform-challenges/challenge2/lamp_stack/website_content/"
  }
  networks_advanced  {
    name = docker_network.private_network.name
  }
}

