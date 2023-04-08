#!/bin/bash

[ ! -d "project" ] && mkdir projects

for name in `cat info-alunos | awk -F ':' '{print $1}'` ; do
  mkdir "projects/${name}"
  password=$(cat info-alunos | grep ${name} | awk -F ':' '{print $2}')
  port=$(cat info-alunos | grep ${name} | awk -F ':' '{print $3}')
  echo "version: '3.3'

services:
  db:
    image: mariadb:10.6
    restart: always
    container_name: ${name}_db
    environment:
      MARIADB_ROOT_PASSWORD: project-sql
      MARIADB_USER: ${name}
      MARIADB_PASSWORD : ${password}
    command: mysqld --character-set-server=utf8 --collation-server=utf8_unicode_ci
    volumes:
      - './data:/var/lib/mysql'
    mem_limit: 512M
    mem_reservation: 128M
    cpus: 0.5

  phpmyadmin:
    image: phpmyadmin
    container_name: ${name}_phpmyadmin
    restart: always
    ports:
      - 80${port}:80
    environment:
      - PMA_ARBITRARY=1
    mem_limit: 512M
    mem_reservation: 128M
    cpus: 0.5" > projects/${name}/docker-compose.yml
done