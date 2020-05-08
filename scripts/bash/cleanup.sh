#!/bin/bash

source ./scripts/bash/log.sh

set -eu

function cleanup_terraform {

  logGreen "Start: Cleanup Terraform"
    pwd
    rm -rf paving/$IAAS/.terraform
    rm environments/${IAAS_IN}/${ENV_IN}/output/terraform.tfplan
    rm environments/${IAAS_IN}/${ENV_IN}/output/terraform.tfstate
    rm environments/${IAAS_IN}/${ENV_IN}/output/terraform.tfstate.backup
    rm environments/${IAAS_IN}/${ENV_IN}/output/terraform-outputs.yml
    rm environments/${IAAS_IN}/${ENV_IN}/output/state.yml
  logGreen "End: Cleanup Terraform"

}

function cleanup_downloads {

  logGreen "Start: Cleanup Downloads"
    rm -rf downloads
  logGreen "End: Cleanup Downloads"

}


function cleanup_paving {

  logGreen "Start: Cleanup Paving"
    rm -rf ../paving
    # find . ! -name 'concourse.tf' -type f -exec rm -f {} +
  logGreen "End: Cleanup Paving"

}

function cleanup {

  logGreen "Start: Cleanup"
    cleanup_terraform
    # cleanup_downloads
    # cleanup_paving
  logGreen "End: Cleanup"

}