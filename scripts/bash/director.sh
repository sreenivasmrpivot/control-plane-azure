#!/bin/bash

source ./scripts/bash/log.sh

set -eu

function docker_import_pat_image {

  logGreen "Start: Docker Import Platform Automation Toolkit Image"
    docker import ${DOWNLOAD_DIR}/${PLATFORM_AUTOMATION_TOOLKIT_IMAGE_TGZ} platform-automation-toolkit-image
  logGreen "End: Docker Import Platform Automation Toolkit Image"

}

function create_opsman_vm_from_pat_image {

  logGreen "Start: Create OpsMan VM from Platform Automation Toolkit Image"
    docker run -it --rm -v $PWD:/workspace -w /workspace platform-automation-toolkit-image \
    p-automator create-vm \
        --config ./config/${IAAS}/opsman-config.yml \
        --image-file ${DOWNLOAD_DIR}/ops-manager*.{yml,ova,raw} \
        --vars-file terraform-outputs.yml
  logGreen "End: Create OpsMan VM from Platform Automation Toolkit Image"

}

function delete_opsman_vm {

  logGreen "Start: Create OpsMan VM from Platform Automation Toolkit Image"
    docker run -it --rm -v $PWD:/workspace -w /workspace platform-automation-toolkit-image \
    p-automator delete-vm \
        --config ./config/${IAAS}/opsman-config.yml \
        --image-file ${DOWNLOAD_DIR}/ops-manager*.{yml,ova,raw} \
        --vars-file terraform-outputs.yml
  logGreen "End: Create OpsMan VM from Platform Automation Toolkit Image"

}

function target_opsman {

  logGreen "Start: Target OpsMan"
    export OM_TARGET="$(om interpolate -c terraform-outputs.yml --path /ops_manager_dns)"
  logGreen "End: Target OpsMan"

}

function setup_opsman_auth {

  logGreen "Start: Setup OpsMan Authentication"
    om --env ./config/${IAAS}/env.yml configure-authentication \
    --username ${OM_USERNAME} \
    --password ${OM_PASSWORD} \
    --decryption-passphrase ${OM_DECRYPTION_PASSPHRASE}
  logGreen "End: Setup OpsMan Authentication"

}

function configure_bosh {

  logGreen "Start: Configure BOSH Director"
    om --env ./config/${IAAS}/env.yml configure-director \
    --config ./config/${IAAS}/director-config.yml \
    --vars-file terraform-outputs.yml

    om --env ./config/${IAAS}/env.yml apply-changes \
    --skip-deploy-products
  logGreen "End: Configure BOSH Director"

}

function setup_director {

  logGreen "Start: Setup BOSH Director"
    docker_import_pat_image
    create_opsman_vm_from_pat_image
    target_opsman
    setup_opsman_auth
    configure_bosh
  logGreen "End: Setup BOSH Director"

}