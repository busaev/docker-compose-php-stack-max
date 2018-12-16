#!/usr/bin/env bash

containers=""
httplink=$( docker-compose ps | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\:[0-9]\+->80/tcp' -m 1 )

if [[ ! -z $httplink ]]
then
containers+="open-in-browser $httplink restart containers "
fi
containers+="up docker-compose down docker-compose "


containers+=$(docker-compose config --services | awk '{print $1,"container"}')

echo $containers;

selectContainer=$(dialog --menu "Please choose a container" 15 55 5 $containers 2>&1 >/dev/tty)
clear
case "$selectContainer" in

 restart )
  docker-compose down && docker-compose up -d
 ;;

 up )
 docker-compose up -d
 ;;

 down )
 docker-compose down
 ;;
 open-in-browser )
 xdg-open $(echo "http://$httplink" | cut -d'-' -f 1)
 exit
 ;;
 *)
 mkdir -p ./phpdocker/dcr/$(basename "$PWD")
 touch ./phpdocker/dcr/$(basename "$PWD")/$selectContainer

 clear && docker-compose run -v ./phpdocker/dcr/$(basename "$PWD")/$selectContainer:/root/.bash_history $selectContainer bash
 ;;
esac
