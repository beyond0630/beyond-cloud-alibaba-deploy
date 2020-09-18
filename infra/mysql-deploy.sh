#!/bin/bash

source ./mysql/config.sh 

source ${WORK_DIR}/../global/constants.sh 
source ${WORK_DIR}/../global/function.sh

echo '>>>>>>>>>>>>>> Pull MySQL Image'
pull_image ${MYSQL_IMAGE_NAME}:${MYSQL_IMAGE_TAG}

run() {

    echo '>>>>>>>>>>>>>> Run MySQL Container'

    docker run -d \
        -e MODE=standalone \
        --name ${MYSQL_IMAGE_NAME} \
        --restart always \
        --net beyond-cloud-alibaba \
        --hostname ${MYSQL_IMAGE_NAME} \
        -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
        -p ${MYSQL_PORT}:3306 \
        ${MYSQL_IMAGE_NAME}:${MYSQL_IMAGE_TAG}
}

firewall() {
    firewall-cmd --zone=public --add-port=${MYSQL_PORT}/tcp --permanent && firewall-cmd --reload
}

run
firewall



