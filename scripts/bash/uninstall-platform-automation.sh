#!/bin/bash

source ./scripts/bash/local-environment.sh
source ./scripts/bash/log.sh
source ./scripts/bash/set-env-vars.sh
source ./scripts/bash/install-tools.sh
source ./scripts/bash/director.sh
source ./scripts/bash/iaas-infra-azure.sh
source ./scripts/bash/cleanup.sh

set -eou pipefail

export input=$1
echo $input

# Step 1: Delete Local Environment
cleanup_local_env

# Step 2: Set environment variables
set_env_vars

export TF_VAR_client_id=$input
export client_id=$input
echo $TF_VAR_client_id
echo $client_id

# Step3: Install required tools locally
# install_tools

# Step4: Cleanup Director
cleanup_director

# Step5: Cleanup IaaS components
destroy_iaas_infra

# Step6: Cleanup folders
cleanup