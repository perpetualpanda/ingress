#!/usr/bin/env bash

set -euo pipefail

# Parameters
RESOURCE_GROUP_NAME="${1:?Missing ResourceGroupName}"
LOCATION="${2:?Missing Location}"
PRIMARY_DNS_ZONE="${3:?Missing PrimaryDNSZone}"

# Create resource group
az group create \
  --name "$RESOURCE_GROUP_NAME" \
  --location "$LOCATION" > /dev/null

if [[ "$BUILD_REASON" == "pull_request" ]]; then
    echo "Running WHAT-IF deployment"
    az deployment group what-if \
      --resource-group "$RESOURCE_GROUP_NAME" \
      --template-file ./dns.bicep \
      --parameters PrimaryDNSZone="$PRIMARY_DNS_ZONE"
else
    echo "Running deployment"
    az deployment group create \
      --resource-group "$RESOURCE_GROUP_NAME" \
      --template-file ./dns.bicep \
      --parameters dnszones_primary_name="$PRIMARY_DNS_ZONE"
fi
