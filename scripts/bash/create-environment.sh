#!/bin/bash

source ./scripts/bash/user-input.sh
source ./scripts/bash/log.sh


set -eou pipefail

function get_user_input {

    logGreen "Enter your Target IaaS (aws, azure, gcp, vsphere): "
    read -r IAAS_IN
    export IAAS_IN="${IAAS_IN:-vsphere}"

    logGreen "Enter your local environment name: "
    read -r ENV_IN
    export ENV_IN="${ENV_IN:-default}"

}

function create_local_env {

    logGreen "Start: Create Local Environment"
        mkdir -p ./environments/${IAAS_IN}/${ENV_IN}/config
        mkdir -p ./environments/${IAAS_IN}/${ENV_IN}/output
    logGreen "End: Create Local Environment"
    
}

function copy_base_templates {

    logGreen "Start: Copy base templates"
        cp -a ./config/${IAAS_IN}/. ./environments/${IAAS_IN}/${ENV_IN}/config/
        cp -a ./config/config-secrets.yml ./environments/${IAAS_IN}/${ENV_IN}/config/
        cp -a ./config/config.yml ./environments/${IAAS_IN}/${ENV_IN}/config/
    logGreen "End: Copy base templates"

}

get_user_input
create_local_env
copy_base_templates