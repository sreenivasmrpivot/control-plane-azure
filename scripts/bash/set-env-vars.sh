#!/bin/bash

source ./scripts/bash/log.sh

set -eou pipefail

function set_env_vars {

  logGreen "Start: Setting Environment Variables"
    # Local Machine Settings
    export DEFAULT_OS=$(om interpolate --config ./config/config.yml --path /DEFAULT_OS)
    export DEFAULT_ARCH=$(om interpolate --config ./config/config.yml --path /DEFAULT_ARCH)
    export DOWNLOAD_DIR=$(om interpolate --config ./config/config.yml --path /DOWNLOAD_DIR)

    # Secrets
    export PIVNET_TOKEN=$(om interpolate --config ./config/config-secrets.yml --path /PIVNET_TOKEN)

    # IaaS settings
    export IAAS=$(om interpolate --config ./config/config.yml --path /IAAS)
    export TF_VAR_environment_name=$(om interpolate --config ./config/config.yml --path /TF_VAR_environment_name)
    export TF_VAR_hosted_zone=$(om interpolate --config ./config/config.yml --path /TF_VAR_hosted_zone)

    # Azure settings
    export CLOUD_NAME=$(om interpolate --config ./config/config-${IAAS}.yml --path /CLOUD_NAME)
    export TF_VAR_tenant_id=$(om interpolate --config ./config/config-secrets.yml --path /TF_VAR_tenant_id)
    export TF_VAR_subscription_id=$(om interpolate --config ./config/config-secrets.yml --path /TF_VAR_subscription_id)
    export TF_VAR_location=$(om interpolate --config ./config/config.yml --path /TF_VAR_location)
    export TF_VAR_app_name=$(om interpolate --config ./config/config-secrets.yml --path /TF_VAR_app_name)
    export TF_VAR_client_secret=$(om interpolate --config ./config/config-secrets.yml --path /TF_VAR_client_secret)
    export IDENTIFIER_URIS=$(om interpolate --config ./config/config-secrets.yml --path /IDENTIFIER_URIS)

    # Product Versions
    export PLATFORM_AUTOMATION_VERSION=$(om interpolate --config ./config/config.yml --path /PLATFORM_AUTOMATION_VERSION)
    export PLATFORM_AUTOMATION_PRODUCT_SLUG=$(om interpolate --config ./config/config.yml --path /PLATFORM_AUTOMATION_PRODUCT_SLUG)
    export PLATFORM_AUTOMATION_TOOLKIT_IMAGE_TGZ=$(om interpolate --config ./config/config.yml --path /PLATFORM_AUTOMATION_TOOLKIT_IMAGE_TGZ)
    export CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION=$(om interpolate --config ./config/config.yml --path /CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION)
    export CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG=$(om interpolate --config ./config/config.yml --path /CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG)
    export OPS_MANAGER_VERSION=$(om interpolate --config ./config/config.yml --path /OPS_MANAGER_VERSION)
    export OPS_MANAGER_VERSION_PRODUCT_SLUG=$(om interpolate --config ./config/config.yml --path /OPS_MANAGER_VERSION_PRODUCT_SLUG)
    export DOWNLOAD_BOSH_ASSETS=$(om interpolate --config ./config/config.yml --path /DOWNLOAD_BOSH_ASSETS)
    export UBUNTU_XENIAL_STEMCELL_VERSION=$(om interpolate --config ./config/config.yml --path /UBUNTU_XENIAL_STEMCELL_VERSION)
    export UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG=$(om interpolate --config ./config/config.yml --path /UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG)
    export AWS_HEAVY_STEMCELL=$(om interpolate --config ./config/config.yml --path /AWS_HEAVY_STEMCELL)

    # OpsMan
    export OM_USERNAME=$(om interpolate --config ./config/config-secrets.yml --path /OM_USERNAME)
    export OM_PASSWORD=$(om interpolate --config ./config/config-secrets.yml --path /OM_PASSWORD)
    export OM_DECRYPTION_PASSPHRASE=$(om interpolate --config ./config/config-secrets.yml --path /OM_DECRYPTION_PASSPHRASE)

  logGreen "End: Setting Environment Variables"

}