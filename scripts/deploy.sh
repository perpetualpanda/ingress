#!/usr/bin/env bash

set -euo pipefail

BICEP_TEMPLATE="./main.bicep"
DEPLOYMENT_TYPE="${1:-WHATIF}" # default to WHATIF

echo "Deployment type: ${DEPLOYMENT_TYPE}"

if [[ "${DEPLOYMENT_TYPE}" == "DEPLOY" ]]; then
    az deployment sub create \
      --location "${LOCATION}" \
      --template-file "${BICEP_TEMPLATE}"
else
    az deployment sub what-if \
      --location "${LOCATION}" \
      --template-file "${BICEP_TEMPLATE}"
fi
