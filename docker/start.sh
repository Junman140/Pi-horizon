#!/bin/bash

set -e

# Use the dirname directly, without changing directories
if [[ $BASH_SOURCE = */* ]]; then
    DOCKER_DIR=${BASH_SOURCE%/*}/
else
    DOCKER_DIR=./
fi

echo "Docker dir is $DOCKER_DIR"

NETWORK=${1:-testnet}

case $NETWORK in
  standalone)
    DOCKER_FLAGS="-f ${DOCKER_DIR}docker-compose.yml -f ${DOCKER_DIR}docker-compose.standalone.yml"
    echo "running on standalone network"
    ;;

  pubnet)
    DOCKER_FLAGS="-f ${DOCKER_DIR}docker-compose.yml -f ${DOCKER_DIR}docker-compose.pubnet.yml"
    echo "running on public network"
    ;;

  pitestnet2|pitestnet)
    DOCKER_FLAGS="-f ${DOCKER_DIR}docker-compose.yml -f ${DOCKER_DIR}docker-compose.pi-testnet.yml"
    echo "running on Pi testnet2"
    ;;

  pitestnet1)
    DOCKER_FLAGS="-f ${DOCKER_DIR}docker-compose.yml -f ${DOCKER_DIR}docker-compose.pi-testnet1.yml"
    echo "running on Pi testnet1"
    ;;

  testnet)
    DOCKER_FLAGS="-f ${DOCKER_DIR}docker-compose.yml"
    echo "running on test network"
    ;;

  *)
    echo  "$1 is not a supported option (use: standalone, pubnet, testnet, pitestnet1, pitestnet2)"
    exit 1
    ;;
esac

docker-compose $DOCKER_FLAGS up --build -d