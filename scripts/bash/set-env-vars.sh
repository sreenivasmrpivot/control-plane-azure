#!/bin/bash

source ./scripts/bash/log.sh

set -eou pipefail

function set_env_vars {

  logGreen "Start: Setting Environment Variables"
    # Local Machine Settings
    export DEFAULT_OS=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /DEFAULT_OS)
    export DEFAULT_ARCH=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /DEFAULT_ARCH)
    export DOWNLOAD_DIR=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /DOWNLOAD_DIR)

    # Secrets
    export PIVNET_TOKEN=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets.yml --path /PIVNET_TOKEN)

    # IaaS settings
    export IAAS=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /IAAS)
    export TF_VAR_environment_name=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /TF_VAR_environment_name)
    export TF_VAR_hosted_zone=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /TF_VAR_hosted_zone)

    # Azure settings
    export CLOUD_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-${IAAS_IN}.yml --path /CLOUD_NAME)
    export TF_VAR_tenant_id=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets-${IAAS_IN}.yml --path /TF_VAR_tenant_id)
    export TF_VAR_subscription_id=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets-${IAAS_IN}.yml --path /TF_VAR_subscription_id)
    export TF_VAR_location=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-${IAAS_IN}.yml --path /TF_VAR_location)
    export TF_VAR_app_name=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets-${IAAS_IN}.yml --path /TF_VAR_app_name)
    export TF_VAR_client_id=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets-${IAAS_IN}.yml --path /TF_VAR_client_id)
    export TF_VAR_client_secret=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets-${IAAS_IN}.yml --path /TF_VAR_client_secret)
    export TF_VAR_identifier_uris=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets-${IAAS_IN}.yml --path /TF_VAR_identifier_uris)

    # Product Versions
    export PLATFORM_AUTOMATION_VERSION=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/RELEASE_VERSION)
    export PLATFORM_AUTOMATION_PRODUCT_SLUG=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/PRODUCT_SLUG)
    export PLATFORM_AUTOMATION_TOOLKIT_IMAGE_TGZ=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/TOOLKIT_IMAGE_TGZ)

    export PLATFORM_AUTOMATION_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/FILES/FILE1/ID)
    export PLATFORM_AUTOMATION_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/FILES/FILE1/NAME)
    export PLATFORM_AUTOMATION_FILE2_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/FILES/FILE2/ID)
    export PLATFORM_AUTOMATION_FILE2_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/PLATFORM_AUTOMATION/FILES/FILE2/NAME)

    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_VERSION=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/RELEASE_VERSION)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_PRODUCT_SLUG=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/PRODUCT_SLUG)

    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE1/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE1/NAME)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE2_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE2/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE2_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE2/NAME)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE3_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE3/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE3_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE3/NAME)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE4_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE4/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE4_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE4/NAME)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE5_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE5/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE5_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE5/NAME)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE6_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE6/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE6_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE6/NAME)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE7_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE7/ID)
    export CONCOURSE_FOR_VMWARE_TANZU_PLATFORM_AUTOMATION_FILE7_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/CONCOURSE_FOR_VMWARE_TANZU/PLATFORM_AUTOMATION/FILES/FILE7/NAME)

    export OPS_MANAGER_VERSION=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/RELEASE_VERSION)
    export OPS_MANAGER_VERSION_PRODUCT_SLUG=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/PRODUCT_SLUG)
    export DOWNLOAD_BOSH_ASSETS=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/DOWNLOAD_BOSH_ASSETS)

    export OPS_MANAGER_AZURE_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/azure/FILE1/ID)
    export OPS_MANAGER_AZURE_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/azure/FILE1/NAME)
    export OPS_MANAGER_AZURE_FILE2_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/azure/FILE2/ID)
    export OPS_MANAGER_AZURE_FILE2_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/azure/FILE2/NAME)
    export OPS_MANAGER_AWS_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/aws/FILE1/ID)
    export OPS_MANAGER_AWS_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/aws/FILE1/NAME)
    export OPS_MANAGER_AWS_FILE2_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/aws/FILE2/ID)
    export OPS_MANAGER_AWS_FILE2_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/aws/FILE2/NAME)
    export OPS_MANAGER_GCP_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/gcp/FILE1/ID)
    export OPS_MANAGER_GCP_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/gcp/FILE1/NAME)
    export OPS_MANAGER_GCP_FILE2_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/gcp/FILE2/ID)
    export OPS_MANAGER_GCP_FILE2_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/gcp/FILE2/NAME)
    export OPS_MANAGER_OPENSTACK_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/openstack/FILE1/ID)
    export OPS_MANAGER_OPENSTACK_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/openstack/FILE1/NAME)
    export OPS_MANAGER_VSPHERE_FILE1_ID=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/vsphere/FILE1/ID)
    export OPS_MANAGER_VSPHERE_FILE1_NAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/OPS_MANAGER/FILES/vsphere/FILE1/NAME)

    export UBUNTU_XENIAL_STEMCELL_VERSION=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/UBUNTU_XENIAL_STEMCELL/RELEASE_VERSION)
    export UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/UBUNTU_XENIAL_STEMCELL/PRODUCT_SLUG)
    export AWS_HEAVY_STEMCELL=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config.yml --path /PRODUCTS/UBUNTU_XENIAL_STEMCELL/AWS_HEAVY_STEMCELL)

    # OpsMan
    export OM_USERNAME=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets.yml --path /OM_USERNAME)
    export OM_PASSWORD=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets.yml --path /OM_PASSWORD)
    export OM_DECRYPTION_PASSPHRASE=$(om interpolate --config ./environments/${IAAS_IN}/${ENV_IN}/config/config-secrets.yml --path /OM_DECRYPTION_PASSPHRASE)

  logGreen "End: Setting Environment Variables"

}