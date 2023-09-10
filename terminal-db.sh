#!/bin/bash

# enter database nodedb
docker compose -p node-nginx exec database mysql --user=root --password=root nodedb

