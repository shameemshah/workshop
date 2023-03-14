#!/usr/bin/env bash
if sudo docker pull golang:1.19-alpine3.17 && sudo docker pull alpine:3.17 && \
   sudo docker images --filter=reference='golang:1.19-alpine3.17' --filter=reference='alpine:3.17'; then
    echo "You are good to go for the devops workshop!"
else
    echo "An error occurred. Please connect with your workshop moderator."
fi


