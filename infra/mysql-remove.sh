#!/bin/bash

source ./mysql/config.sh

docker rm -f ${MYSQL_CONTAINER_NAME}