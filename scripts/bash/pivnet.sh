#!/bin/bash

source ./scripts/bash/log.sh

set -eou pipefail

function login_pivnet {

  logGreen "Start: Login Pivnet"
    pivnet login --api-token $PIVNET_TOKEN
  logGreen "End: Login Pivnet"

}

function download_pivnet_file {

  logGreen "Start: Downloading $5"
    pivnet download-product-files -p "$1" -r "$2" -i "$3" -d "$4"
  logGreen "End: Downloading $5"

}

function logout_pivnet {

  logGreen "Start: Logout Pivnet"
    pivnet login --api-token $PIVNET_TOKEN
  logGreen "End: Logout Pivnet"

}