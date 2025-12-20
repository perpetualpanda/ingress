#!/usr/bin/env bash

set -euo pipefail

# Parameters
BICEP_TEMPLATE="./dns.bicep"
RESOURCE_GROUP_NAME="${1:?Missing RESOURCE_GROUP_NAME}"
LOCATION="${2:?Missing LOCATION}"
PRIMARY_DNS_ZONE="${3:?Missing PRIMARY_DNS_ZONE}"
DEPLOYMENT_TYPE="${4:-WHATIF}" # default to 'WHATIF' if not provided

echo "Deployment type: ${DEPLOYMENT_TYPE}"

# Create resource group
az group create \
  --name "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" > /dev/null

if [[ "${DEPLOYMENT_TYPE}" == "DEPLOY" ]]; then
    echo "Running DNS deployment"
    az deployment group create \
      --resource-group "${RESOURCE_GROUP_NAME}" \
      --template-file "${BICEP_TEMPLATE}" \
      --parameters dnszones_primary_name="${PRIMARY_DNS_ZONE}"
else
    echo "Running what if DNS deployment"
    az deployment group what-if \
      --resource-group "${RESOURCE_GROUP_NAME}" \
      --template-file "${BICEP_TEMPLATE}" \
      --parameters dnszones_primary_name="${PRIMARY_DNS_ZONE}"
fi
