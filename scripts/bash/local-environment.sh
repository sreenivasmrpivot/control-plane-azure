#!/bin/bash

source ./scripts/bash/user-input.sh
source ./scripts/bash/log.sh


set -eou pipefail

function get_env_details {

    logGreen "Enter your Target IaaS (aws, azure, gcp, vsphere): "
    read -r IAAS_IN
    export IAAS_IN="${IAAS_IN:-vsphere}"

    logGreen "Enter your local environment name: "
    read -r ENV_IN
    export ENV_IN="${ENV_IN:-default}"

}

function create_local_env {

    if [ -z "$(ls -A ./environments/${IAAS_IN}/${ENV_IN})" ]
    then
        logGreen "Environment folders do not pre-exist"
        create_env_folders
        copy_base_templates
    else
        logGreen "Environment folders pre-exist. You may lose config / state. Do you want to ovre-write existing settings? [yes] / [no]"
        read -r OVERWRITE_ENV
        if [ OVERWRITE_ENV == "yes" ]
        then
            create_env_folders
            copy_base_templates
        else
            logGreen "Applying existing Environment config / state"            
        fi
    fi

}

function create_env_folders {

    logGreen "Start: Create Environment folders"
        mkdir -p ./environments/${IAAS_IN}/${ENV_IN}/config
        mkdir -p ./environments/${IAAS_IN}/${ENV_IN}/output
    logGreen "End: Create Environment folders"

}

function copy_base_templates {

    logGreen "Start: Copy base templates"
        cp -a ./config/${IAAS_IN}/. ./environments/${IAAS_IN}/${ENV_IN}/config/
        cp -a ./config/config-secrets.yml ./environments/${IAAS_IN}/${ENV_IN}/config/
        cp -a ./config/config.yml ./environments/${IAAS_IN}/${ENV_IN}/config/
    logGreen "End: Copy base templates"

}

function setup_local_env {

    logGreen "Start: Setup local environment"
        get_env_details
        create_local_env
    logGreen "End: Setup local environment"

}

function cleanup_local_env {

    logGreen "Start: Cleanup local environment"
        get_env_details
        logGreen "Are you sure to delete the local environment? [yes] / [no]"
        read -r OVERWRITE_ENV
        if [ OVERWRITE_ENV == "yes" ]
        then
            logGreen "Deletig local environment"
            rm -rf -p ./environments/${IAAS_IN}/${ENV_IN}
        else
            logGreen "Skipping local environment deletion"            
        fi
    logGreen "End: Cleanup local environment"

}
