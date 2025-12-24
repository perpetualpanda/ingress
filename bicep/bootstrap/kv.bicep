param key_vault_name          string
param managed_id_name         string
param ci_service_principal_id string
param tags                    object

resource user_assigned_identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: managed_id_name
  location: resourceGroup().location
  tags: tags
}

resource key_vault 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: key_vault_name
  location: resourceGroup().location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        // allow read access to the key vault for the managed identity
        object_id: user_assigned_identity.id
        permissions: {
          secrets: ['get', 'list']
        }
      }
      {
        // allow write access to the key vault for the ci service principal
        object_id: ci_service_principal_id
        permissions: {
          secrets: ['get', 'list', 'set', 'delete']
        }
      }
    ]
  }
}

output key_vault_uri string = key_vault.properties.vaultUri
output managed_identity_id string = user_assigned_identity.id
