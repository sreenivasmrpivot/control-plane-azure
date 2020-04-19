#!/bin/bash

source ./scripts/bash/log.sh
source ./scripts/bash/set-env-vars.sh
source ./scripts/bash/install-tools.sh
source ./scripts/bash/iaas-infra-azure.sh
source ./scripts/bash/cleanup.sh

set -eou pipefail

export TF_VAR_client_id=$1

set_env_vars


# Step1: Install required tools locally
# install_tools

# Step2: Download the required products
destroy_iaas_infra

# Step3: Cleanup folders
# cleanup