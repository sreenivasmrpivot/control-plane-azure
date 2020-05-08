#!/bin/bash

source ./scripts/bash/local-environment.sh
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

function install_platform {

  # Step 1: Create Local Environment
  setup_local_env

  logGreen "Set necessary configuration in the files under ./environments/${IAAS_IN}/${ENV_IN}"

  logGreen "Are you done setting config for the environment and do you want to proceed with the install? [yes] / [no]"
  read -r PROCCED_INSTALL
  if [ $PROCCED_INSTALL == "yes" ]
  then
    logGreen "Start: Install"

    # Step 2: Check mandatory install params
    mandatory_install_params_check

    # Step 3: Set environment variables
    set_env_vars

    # Step 4: Load infra source
    # load_infra_source

    # Step 5: Get User Input
    # get_user_input

    # Step 6: Login to pivnet
    # login_pivnet

    # Step 7: Install required tools locally
    # install_tools

    # Step 8: Download the required products
    # download_products

    # Step 9: Setup IaaS components
    # create_iaas_infra

    # Step 10: Deploy Director
    # setup_director

    # Step 11: Upload Realeases and Stemcells to BOSH Director
    # upload_releases_stemcells

    # Step 12: Prepare Concourse BOSH Deployment
    # deploy_concourse

    # Step 13: Test Concourse BOSH Deployment
    # test_deployment

    # Step 14: Logout to pivnet
    # logout_pivnet
        
  else
      logGreen "Skipping install"            
  fi

}

install_platform
