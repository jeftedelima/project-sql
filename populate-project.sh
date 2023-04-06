#!/bin/bash

for name in `cat info-alunos | awk -F ':' '{print $1}'` ; do
  mkdir "projects/${name}"
  password=$(cat info-alunos | grep ${name} | awk -F ':' '{print $2}')
  port=$(cat info-alunos | grep ${name} | awk -F ':' '{print $3}')
  echo "version: '3.3'

services:
  db:
    image: mariadb:10.6
    restart: always
    environment:
      MARIADB_ROOT_PASSWORD: ${password}
    volumes:
      - './data:/var/lib/mysql'
    mem_limit: 512M
    mem_reservation: 128M
    cpus: 0.5

  phpmyadmin:
    image: phpmyadmin
    restart: always
    ports:
      - 80${port}:80
    environment:
      - PMA_ARBITRARY=1
    mem_limit: 512M
    mem_reservation: 128M
    cpus: 0.5" > projects/${name}/docker-compose.yml
done