#!/bin/bash

source ./scripts/bash/user-input.sh
source ./scripts/bash/log.sh
source ./scripts/bash/set-env-vars.sh
source ./scripts/bash/pivnet.sh
source ./scripts/bash/download-products.sh
source ./scripts/bash/install-tools.sh

source ./scripts/bash/director.sh
source ./scripts/bash/upload-releases.sh
source ./scripts/bash/deploy-concourse.sh
source ./scripts/bash/test-deployment.sh

set -eou pipefail

function get_user_input {

    logGreen "Enter your Operating System (linux, darwin, windows): "
    read -r OS_IN
    export OS="${OS:-${DEFAULT_OS}}"
    echo $OS

    logGreen "Enter your OS Architecture (amd64, 386): "
    read -r ARCH_IN
    export ARCH="${ARCH:-${DEFAULT_ARCH}}"
    echo $ARCH

}

function load_infra_source {

  logGreen "Start: Load Infra Source"

    case $IAAS in
      "azure" )
        source ./scripts/bash/iaas-infra-azure.sh
       ;;
      "aws" )
        source ./scripts/bash/iaas-infra-aws.sh
        ;;
      "gcp" )
        source ./scripts/bash/iaas-infra-gcp.sh
        ;;
      "vsphere" )
        source ./scripts/bash/iaas-infra-azure.sh
        ;;
      *)

        logGreen "Reached default ;)"

        ;;
    esac

  logGreen "End: Load Infra Source"

}

# Step 1: Check mandatory install params
mandatory_install_params_check

# Step 2: Set environment variables
set_env_vars

# Step 2: Load infra source
load_infra_source

# Step 3: Set environment variables
get_user_input

# Step 4: Login to pivnet
# login_pivnet

# Step 45: Install required tools locally
# install_tools

# Step 6: Download the required products
# download_products

# Step 7: Setup Working Directory and Shell Setup
# create_iaas_infra

# Step 8: Deploy Director
setup_director

# Step 9: Upload Realeases and Stemcells to BOSH Director
# upload_releases_stemcells

# Step 10: Prepare Concourse BOSH Deployment
# deploy_concourse

# Step 11: Test Concourse BOSH Deployment
# test_deployment

# Step 12: Logout to pivnet
logout_pivnet