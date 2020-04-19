#!/bin/bash

source ./scripts/bash/log.sh

set -eou pipefail

function copy_paving_old {

  logGreen "Start: Copying: Paving Repo contents required"
    # cp -Ra paving/${IAAS} paving-${IAAS}
    # mkdir paving-${IAAS}
    cp -a ../paving/$IAAS/. paving-$IAAS 
    rm paving-$IAAS/.gitignore 
    rm paving-$IAAS/README.md
  logGreen "End: Copying: Paving Repo contents required"

}

function copy_terraform {

  logGreen "Start: Copying: Terraform contents required"
    cp -a ./terraform/$IAAS/. ./paving-stage/paving/$IAAS 
  logGreen "End: Copying: Terraform contents required"

}

function clone_paving_old {

  logGreen "Start: Cloning: Paving Repo"
    pwd
    rm -rf ../paving
    cd ..
    git clone https://github.com/pivotal/paving.git
    cd platform-automation
    pwd
  logGreen "End: Cloning: Paving Repo"

}

function clone_paving {

  logGreen "Start: Cloning: Paving Repo"
    pwd
    rm -rf ./paving-stage/paving
    cd ./paving-stage
    git clone https://github.com/pivotal/paving.git
    cd ..
    pwd
  logGreen "End: Cloning: Paving Repo"

}

function move_to_staged_paving {

  logGreen "Start: Move to Paving"
    cd ./paving-stage/paving/${IAAS}
    pwd
  logGreen "End: Move to Paving"

}

function az_login {

  logGreen "Start: Login to Azure"
    az cloud set --name ${CLOUD_NAME}
    az login

}

function set_subscription {

  logGreen "Start: Set subscription"
    az account set --subscription ${TF_VAR_subscription_id}

}

function create_aad_app {

  logGreen "Start: Create Azure AD App"
    az ad app create --display-name "${TF_VAR_app_name}" --password ${TF_VAR_client_secret} --homepage "http://BOSHAzureCPI" --identifier-uris ${IDENTIFIER_URIS}
    export app_id=$(az ad app list --display-name "${TF_VAR_app_name}" --query [].appId -o tsv)
    echo "AppId: "${app_id}
    export TF_VAR_client_id=${app_id}
  logGreen "End: Create Azure AD App"

}

function delete_aad_app {

  logGreen "Start: Delete Azure AD App"
    az ad app delete --id ${IDENTIFIER_URIS}
  logGreen "End: Delete Azure AD App"

}
function create_configure_service_principal {

  logGreen "Start: Create and Configure Service Principal"
    # echo ${TF_VAR_client_id}
    az ad sp create --id "${app_id}"
    export servicePrincipalAppId=$(az ad sp list --display-name "${TF_VAR_app_name}" --query "[].appId" -o tsv)
    echo "servicePrincipalAppId: "${servicePrincipalAppId}
    az role assignment create --assignee ${servicePrincipalAppId} --role "Owner" --scope /subscriptions/${TF_VAR_subscription_id}
    az role assignment list --assignee ${servicePrincipalAppId}
  logGreen "End: Create and Configure Service Principal"

}

function delete_service_principal {

  logGreen "Start: Delete Service Principal"
    az ad sp delete --id "${TF_VAR_client_id}"
  logGreen "End: Delete Service Principal"

}
function verify_service_principal {

  logGreen "Start: Verify Service Principal"
    az login --username "${TF_VAR_client_id}" --password ${TF_VAR_client_secret} --service-principal --tenant ${TF_VAR_tenant_id}
  logGreen "End: Verify Service Principal"

}

function perform_registrations {

  logGreen "Start: Perform Registrations"
    az provider register --namespace Microsoft.Storage
    az provider register --namespace Microsoft.Network
    az provider register --namespace Microsoft.Compute
  logGreen "End: Perform Registrations"

}

function target_azure {

  logGreen "Start: Target Azure"
    az_login
    set_subscription
  logGreen "End: Target Azure"

}

function prerequisites {

  logGreen "Start: PreRequisites"
    create_aad_app
    create_configure_service_principal
    verify_service_principal
    perform_registrations
  logGreen "End: PreRequisites"

}

function apply_terraform {

  logGreen "Start: Apply Terraform"
    terraform init
    terraform refresh
    terraform plan -out=terraform.tfplan
    terraform apply -parallelism=5 terraform.tfplan
    terraform output stable_config > ../terraform-outputs.yml
    export CONCOURSE_URL="$(terraform output concourse_url)"
  logGreen "End: Apply Terraform"

}

function destroy_terraform {

  logGreen "Start: Destroy Terraform"
    terraform init
    terraform refresh
    terraform plan -out=terraform.tfplan
    terraform destroy
  logGreen "End: Destroy Terraform"

}

function create_iaas_infra {

  logGreen "Start: Create IaaS Infrastructure"
    target_azure
    prerequisites
    # clone_paving_old
    # copy_paving_old
    clone_paving
    copy_terraform
    move_to_staged_paving
    apply_terraform
    cd .
  logGreen "End: Create IaaS Infrastructure"

}

function destroy_iaas_infra {

  logGreen "Start: Destroy IaaS Infrastructure"
    target_azure
    move_to_staged_paving
    destroy_terraform
    delete_service_principal
    # delete_aad_app
    cd ../..
  logGreen "End: Destroy IaaS Infrastructure"

}