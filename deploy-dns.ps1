param (
    [Parameter(Mandatory)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory)]
    [string]$Location,

    [Parameter(Mandatory)]
    [string]$PrimaryDNSZone,

    [Parameter(Mandatory)]
    [string]$BuildReason
)

Write-Host "Build reason: $BuildReason"

az group create `
  --name $ResourceGroupName `
  --location $Location | Out-Null

if ($BuildReason -eq "PullRequest") {
    Write-Host "Running WHAT-IF deployment"
    az deployment group what-if `
      --resource-group $ResourceGroupName `
      --template-file ./dns.bicep `
      --parameters PrimaryDNSZone=$PrimaryDNSZone
} else {
    Write-Host "Running deployment"
    az deployment group create `
      --resource-group $ResourceGroupName `
      --template-file ./dns.bicep `
      --parameters dnszones_primary_name=$PrimaryDNSZone
}
