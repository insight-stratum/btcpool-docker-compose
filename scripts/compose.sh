#!/usr/bin/env bash

ACTION="$1"
if [ "${ACTION}" = "start" ]; then
  DOCKER_CMD="up -d"
elif [ "${ACTION}" = "stop" ]; then
  DOCKER_CMD="down"
elif [ "${ACTION}" = "ps" ]; then
  DOCKER_CMD="ps"
fi

if [ "${STACK}" = "prometheus" ]; then
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.override.prometheus-exporters.yml \
    -f docker-compose.override.prometheus-server.yml \
    $DOCKER_CMD
elif [ "${STACK}" = "testnet" ]; then
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.override.testnet.yml \
    $DOCKER_CMD
elif [ "${STACK}" = "exporters" ]; then
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.override.prometheus-exporters.yml \
    $DOCKER_CMD
elif [ "${STACK}" = "miner" ]; then
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.override.ckb-miner.yml \
    $DOCKER_CMD
else
  docker-compose $DOCKER_CMD
fi

