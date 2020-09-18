#!/bin/bash

source ./seata/config.sh

rm -rf ${SEATA_SERVER_DIR}
docker rm -f ${SEATA_CONTAINER_NAME}