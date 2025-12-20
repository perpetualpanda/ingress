#!/usr/bin/env bash

set -euo pipefail

# Parameters
BICEP_TEMPLATE="./dns.bicep"
RESOURCE_GROUP_NAME="${1:?Missing RESOURCE_GROUP_NAME}"
LOCATION="${2:?Missing LOCATION}"
PRIMARY_DNS_ZONE="${3:?Missing PRIMARY_DNS_ZONE}"
EVENT_TRIGGER="${4:-push}" # default to 'push' if not provided

echo "Event Trigger: ${EVENT_TRIGGER}"

# Create resource group
az group create \
  --name "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" > /dev/null

if [[ "${EVENT_TRIGGER}" == "pull_request" ]]; then
    echo "Running WHAT-IF deployment"
    az deployment group what-if \
      --resource-group "${RESOURCE_GROUP_NAME}" \
      --template-file ${BICEP_TEMPLATE} \
      --parameters PrimaryDNSZone="${PRIMARY_DNS_ZONE}"
else
    echo "Running deployment"
    az deployment group create \
      --resource-group "${RESOURCE_GROUP_NAME}" \
      --template-file "${BICEP_TEMPLATE}" \
      --parameters dnszones_primary_name="${PRIMARY_DNS_ZONE}"
fi
