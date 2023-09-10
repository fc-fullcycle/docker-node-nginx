#!/bin/bash

# remove/down services and local images
docker compose -p node-nginx down --rmi local -v

