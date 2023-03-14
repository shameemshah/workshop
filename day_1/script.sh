#!/usr/bin/env bash

# Check if curl is installed, if not, install it
if ! [ -x "$(command -v curl)" ]; then
  if [ "$(uname)" == "Darwin" ]; then
    echo 'Error: curl is not installed. Installing now...' >&2
    brew install curl
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'Error: curl is not installed. Installing now...' >&2
    sudo apt-get update
    sudo apt-get install -y curl
  else
    echo 'Errorcode: 0111, Please share the error code  with your workshop moderator' >&2
    exit 1
  fi
fi

# Check if bash is installed, if not, install it
if ! [ -x "$(command -v bash)" ]; then
  if [ "$(uname)" == "Darwin" ]; then
    echo 'Error: bash is not installed. Installing now...' >&2
    brew install bash
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'Error: bash is not installed. Installing now...' >&2
    sudo apt-get update
    sudo apt-get install -y bash
  else
    echo 'Errorcode: 0222, Please share the error code  with your workshop moderator' >&2
    exit 1
  fi
fi

# Run docker pull commands and check for success
if sudo docker pull golang:1.19-alpine3.17 && sudo docker pull alpine:3.17 && \
   sudo docker images --filter=reference='golang:1.19-alpine3.17' --filter=reference='alpine:3.17'; then
    echo "You are good to go for the devops workshop day 1"
else
    echo "Errorcode: 0503"
    echo "An error occurred. Please share the error code with your workshop moderator."
fi
