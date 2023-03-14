#!/usr/bin/env bash

# Check if curl is installed, if not, install it

function log() {
    message=$1
    echo -e "\033[33mInfo: ${message}\033[0m"
}

function err() {
    local errorcode=$1
    echo -e "\033[31mError code: $errorcode, Please share the error code with your workshop moderator\033[0m"
    exit 1
}


function validate(){
    if ! which curl &>/dev/null; then
      if [ "$(uname)" == "Darwin" ]; then
        log "curl is not installed. Installing now..." >&2
        brew install curl >&2
      elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        log "curl is not installed. Installing now..." >&2
        sudo apt-get update >&2
        sudo apt-get install -y curl >&2
      else
        err "1111"
      fi
    fi

    # Check if bash is installed, if not, install it
    if ! which bash &>/dev/null; then
      if [ "$(uname)" == "Darwin" ]; then
        log "bash is not installed. Installing now..." >&2
        brew install bash
      elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        log 'bash is not installed. Installing now...' >&2
        sudo apt-get update
        sudo apt-get install -y bash
      else
        err "2222"
      fi
    fi

    # Check if UNZIP is installed, if not, install it  
    if ! which unzip &>/dev/null; then
      if [ "$(uname)" == "Darwin" ]; then
        log "unzip is not installed. Installing now..." >&2
        brew install unzip
      elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        log 'unzip is not installed. Installing now...' >&2
        sudo apt-get update
        sudo apt-get install -y unzip
      else
        err "3333"
      fi
    fi
}

function download_asset(){
  # set the download URL
  day=$1
  DOWNLOAD_URL=$2
  # set the filename
  FILENAME=$3
  mkdir -p ~/Desktop/devops_workshop
  cd ~/Desktop/devops_workshop
  # download the file using curl
  
  log "Downloading Day $day assets" 
  curl -L "$DOWNLOAD_URL" -o "$FILENAME"  &> /dev/null
  # extract the zip archive
  unzip -o "$FILENAME" &> /dev/null
  rm $FILENAME
}

function day1(){
    # Run docker pull commands and check for success
    log "Downloading the necessary images for the workshop, Please wait..."
    # Check if Docker daemon is running
    if [ "$(uname)" == "Darwin" ]; then
      if ! docker info &> /dev/null; then
        log "Docker daemon is not running. Starting Docker daemon..."
        open /Applications/Docker.app
        while ! docker info &> /dev/null; do
            sleep 1
        done
      fi
    fi
    if sudo docker pull golang:1.19-alpine3.17  &> /dev/null && sudo docker pull alpine:3.17  &> /dev/null ; then
        log "Validating the docker images"
        sudo docker images --format "{{.Repository}}:{{.Tag}}" --filter=reference='golang:1.19-alpine3.17' --filter=reference='alpine:3.17'
        download_asset 1 "https://drive.google.com/uc?id=1F1GCKXr66umakIrnnKHYcE-5-fSKJyXG" "day-1.zip"
        echo -e "\n\n\033[32m >>>>>>>>> You are good to go for the DevOps workshop Day 1!!  <<<<<<<<<< \033[0m\n"
        message=$'\n\n\e[1m\e[5m\e[38;5;33m      >>>>>>>>> Team-Devops Keyvalue Software Systems  <<<<<<<<<< \e[0m\n'
        echo $message
    else
        err "0503"
    fi
}

validate
day1


