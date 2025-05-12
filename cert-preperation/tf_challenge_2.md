sudo apt-get update && apt-get install wget unzip -y 

wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip

unzip terraform_1.1.5_linux_amd64.zip

mv terraform /usr/local/bin/



resource "docker_image" "php-httpd-image"{
name = "php-httpd:challenge"
build {
path = "/root/code/terraform-challenges/challenge2/lamp_stack/php_httpd"
label = {
challenge="second"
}
}
}

resource "docker_image" "mariadb-image"{

name = "mariadb:challenge"
build {
path = "/root/code/terraform-challenges/challenge2/lamp_stack/custom_db"
label = {
challenge="second"
}
}
}
resource "docker_network" "private_network" {
name = "my_network"
attachable = true
labels  {
  label = "challenge"
   value = "second"
}
}
resource "docker_container" "php-httpd" {
  name  = "webserver"
  image = "php-httpd:challenge"
  hostname = "php-httpd"
  networks_advanced  {
        name = "my_network"
}
ports {
internal = 80
external = 80
}

labels  {
  label = "challenge"
   value = "second"
}
volumes {
container_path = "/var/www/html"
host_path = "/root/code/terraform-challenges/challenge2/lamp_stack/website_content/"
}
}
resource "docker_container" "phpmyadmin" {
  name  = "db_dashboard"
  image = "phpmyadmin/phpmyadmin"
  hostname = "phpmyadmin"
  depends_on = [docker_container.mariadb]
  networks_advanced  {
        name = "my_network"
}

ports {
internal = 80
external = 8081
}

  links = [
    docker_container.mariadb.name
  ]
labels  {
  label = "challenge"
   value = "second"
}
}
resource "docker_volume" "mariadb_volume" {
  name = "mariadb-volume"
}
resource "docker_container" "mariadb" {
  name  = "db"
  image = "mariadb:challenge"
  hostname = "db"
  networks_advanced  {
        name = "my_network"
}
ports {
internal = 3306
external = 3306
}
labels  {
  label = "challenge"
   value = "second"
}
env  = [
"MYSQL_ROOT_PASSWORD=1234",
"MYSQL_DATABASE=simple-website", ]
volumes {
container_path = "/var/lib/mysql"
volume_name = "mariadb-volume"
}
}
