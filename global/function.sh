#!/bin/bash

function create_network() {
  local name=$1
  docker network ls --format "{{.Name}}" | grep ${name} &> /dev/null
  if [ $? -ne 0 ]; then
      docker network create ${name}
  fi
}


pull_image() {
    local name=$1
    docker image inspect ${name} &> /dev/null
    if [ $? -ne 0 ]; then
        while [ 0 -eq 0 ]
        do
            echo ">>>>>> Pull Image: ${name}"
            docker pull ${name}
            if [ $? -eq 0 ]; then
                break
            fi
        done
    fi
}