#!/bin/bash

source ./scripts/bash/log.sh

set -eu

function download_platform_automation_toolkit {

  logGreen "Start: Download Platform Automation Toolkit"

    download_pivnet_file ${PLATFORM_AUTOMATION_PRODUCT_SLUG} "${PLATFORM_AUTOMATION_VERSION}" 639659 ${DOWNLOAD_DIR} "Concourse Tasks"
    download_pivnet_file ${PLATFORM_AUTOMATION_PRODUCT_SLUG} "${PLATFORM_AUTOMATION_VERSION}" 639658 ${DOWNLOAD_DIR} "Docker Image for Concourse Tasks"

  logGreen "End: Download Platform Automation Toolkit"

}

function download_concourse_for_platform_automation {

  logGreen "Start: Download Concourse for Platform Automation Toolkit"

    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 637918 ${DOWNLOAD_DIR} "UAA BOSH Release"
    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 637916 ${DOWNLOAD_DIR} "Postgres BOSH Release"
    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 637915 ${DOWNLOAD_DIR} "Credhub BOSH Release"
    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 621824 ${DOWNLOAD_DIR} "Concourse BOSH 5.5.8"
    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 637913 ${DOWNLOAD_DIR} "Concourse BOSH Deployment"
    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 637912 ${DOWNLOAD_DIR} "BPM BOSH Release"
    download_pivnet_file ${CONCOURSE_FOR_PLATFORM_AUTOMATION_PRODUCT_SLUG} "${CONCOURSE_FOR_PLATFORM_AUTOMATION_VERSION}" 637910 ${DOWNLOAD_DIR} "Backup and Restore SDK BOSH Release"

  logGreen "End: Download Concourse for Platform Automation Toolkit"

}

function download_opsman {

  logGreen "Start: Download OpsMan"

    case $IAAS in
      "azure" )

        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633052 ${DOWNLOAD_DIR} "Ops Manager YAML for Azure - 2.9.0-build.106"
        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633050 ${DOWNLOAD_DIR} "Ops Manager for Azure - 2.9.0-build.106"

        ;;
      "aws" )

        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633049 ${DOWNLOAD_DIR} "Ops Manager YAML for AWS - 2.9.0-build.106"
        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633048 ${DOWNLOAD_DIR} "Ops Manager for AWS - 2.9.0-build.106"

        ;;
      "gcp" )

        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633054 ${DOWNLOAD_DIR} "Ops Manager YAML for GCP - 2.9.0-build.106"
        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633053 ${DOWNLOAD_DIR} "Ops Manager for GCP - 2.9.0-build.106"

        ;;
      "openstack" )

        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633062 ${DOWNLOAD_DIR} "Ops Manager for OpenStack - 2.9.0-build.106"

        ;;
      "vsphere" )

        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633076 ${DOWNLOAD_DIR} "Ops Manager for VSphere - 2.9.0-build.106"

        ;;
      *)

        logGreen "Reached default ;)"

        ;;
    esac

    if [ $DOWNLOAD_BOSH_ASSETS == "true" ]
    then
        download_pivnet_file ${OPS_MANAGER_VERSION_PRODUCT_SLUG} "${OPS_MANAGER_VERSION}" 633043 ${DOWNLOAD_DIR} "BOSH Assets - 2.9.0-build.106"
    fi

  logGreen "End: Download OpsMan"

}

function download_stemcells {

  logGreen "Start: Download Stemcells"

    case $IAAS in
      "azure" )
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654315 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for Azure 456.104"
        ;;
      "aws" )
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654314 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for AWS 456.104"
        ;;
      "gcp" )
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654317 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for GCP 456.104"
        ;;
      "openstack" )
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654319 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for OpenStack 456.104"
        ;;
      "vsphere" )
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654322 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for OpenStack 456.104"
        ;;
      "vcloud" )
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654320 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for OpenStack 456.104"
        ;;
      *)

        logGreen "Reached default ;)"

        ;;
    esac

    if [ $AWS_HEAVY_STEMCELL == "true" ]
    then
        download_pivnet_file ${UBUNTU_XENIAL_STEMCELL_PRODUCT_SLUG} "${UBUNTU_XENIAL_STEMCELL_VERSION}" 654313 ${DOWNLOAD_DIR} "Ubuntu Xenial Stemcell for AWS (Heavy) 456.104"
    fi

  logGreen "End: Download Stemcells"

}

function download_products {

  logGreen "Start: Download Products"
    download_platform_automation_toolkit
    download_concourse_for_platform_automation
    download_opsman
    download_stemcells
  logGreen "End: Download Products"

}