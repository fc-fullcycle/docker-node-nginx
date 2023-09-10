#!/bin/bash

# build image and create/start up services
docker compose -p node-nginx up --build -d

