#!/bin/sh

source ./seata/config.sh
source ${WORK_DIR}/../global/constants.sh
source ${WORK_DIR}/../global/function.sh

echo '>>>>>>>>>>>>>> Pull Seata Image'
pull_image ${SEATA_IMAGE_NAME}:${SEATA_IMAGE_TAG}

docker_cp() {
    echo '>>>>>>>>>>>> Copy Docker Files'
    mkdir -p ${SEATA_SERVER_DIR}

    docker run --name seata -p 8091:8091 -d  ${SEATA_IMAGE_NAME}:${SEATA_IMAGE_TAG}
    docker cp seata:/seata-server ${SEATA_SERVER_DIR}
    docker rm -f seata
}

cp() {
    echo '>>>>>>>>>>>> Copy files'
    /bin/cp -rf ./seata/seata-config/* ${SEATA_SERVER_DIR}/seata-server/resources
}

run() {

    echo '>>>>>>>>>>>>>> Run Seata Container'

    docker run -d \
        --name ${SEATA_CONTAINER_NAME} \
        --restart always \
        --net ${NETWORK_NAME} \
        --hostname ${SEATA_CONTAINER_NAME} \
        -e SEATA_IP=${LINUX_HOST} \
        -p ${SEATA_PORT}:8091 \
        -v ${SEATA_SERVER_DIR}/seata-server:/seata-server \
        --privileged=true \
        ${SEATA_IMAGE_NAME}:${SEATA_IMAGE_TAG}

}

config() {
    echo '>>>> Push Seata Config'
    sh ./seata/nacos-config.sh localhost
}

firewall() {
    firewall-cmd --zone=public --add-port=${SEATA_PORT}/tcp --permanent && firewall-cmd --reload
}

docker_cp
cp
config
run
firewall

