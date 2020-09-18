#!/bin/bash

source ./nacos/config.sh
source ${WORK_DIR}/../global/function.sh

echo '>>>>>>>>>>>>>> Pull Nacos Image'
pull_image ${NACOS_IMAGE_NAME}

run() {

    echo '>>>>>>>>>>>>>> Run Nacos Container'

    docker run -d \
        -e MODE=standalone \
        --name ${NACOS_CONTAINER_NAME} \
        --restart always \
        --net beyond-cloud-alibaba \
        --hostname ${NACOS_CONTAINER_NAME} \
        -p 8848:8848 \
        ${NACOS_IMAGE_NAME}
}

firewall() {
    firewall-cmd --zone=public --add-port=8848/tcp --permanent && firewall-cmd --reload
}

run
firewall



