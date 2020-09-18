#!/bin/bash

WORK_DIR=$(pwd)
SEATA_IMAGE_NAME='seataio/seata-server'
SEATA_IMAGE_TAG='1.3.0'
SEATA_CONTAINER_NAME='seata'
SEATA_PORT='8091'
SEATA_SERVER_DIR=/usr/local/seata