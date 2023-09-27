#!/bin/bash

####################################################################
##### up containers
####################################################################

function up() {
  docker compose -p "$projectName" -f "$dockerComposeFile" up --build -d
}

####################################################################
##### up dev containers
####################################################################

function up-dev() {
  docker compose -p "$projectName" -f "$dockerComposeFile" -f "$dockerComposeDevFile" up --build -d
}

####################################################################
##### down containers
####################################################################

function down() {
  docker compose -p "$projectName" -f "$dockerComposeFile" down --remove-orphans --rmi local
}

####################################################################
##### recreate containers
####################################################################

function recreate() {
   down && up
}

####################################################################
##### recreate dev containers
####################################################################

function recreate-dev() {
   down && up-dev
}

####################################################################
##### terminal db
####################################################################

function terminal-db() {
  docker compose -p "$projectName" -f "$dockerComposeFile" exec database mysql --user=root --password=root nodedb
}

####################################################################
##### Prepare arguments
####################################################################

dockerComposeFile="docker-compose.yml"
dockerComposeDevFile="docker-compose.dev.yml"
projectName="node-nginx"
dateFormat="+%d-%m-%Y %H:%M:%S"
job="$1"

####################################################################
##### Main
####################################################################
case "$job" in
up)
  up
  ;;
up-dev)
  up-dev
  ;;
down)
  down
  ;;
recreate)
  recreate
  ;;
recreate-dev)
  recreate-dev
  ;;
terminal-db)
  terminal-db
  ;;
*)
  printMessage "ERROR: command [$job] not found."
  help
  exit 1
  ;;
esac
