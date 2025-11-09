# Quick Start Tutorial

## Step 1: Basic Hardening
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "WebServer01"
```

## Step 2: Preview Changes
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "WebServer01" -WhatIf
```

## Step 3: Hardening with Backup
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "WebServer01" -Backup
```

## Step 4: Validate Results
```powershell
./scripts/validate-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "WebServer01"
```

## Step 5: Bulk Operations
```powershell
# Create config file
@{
    VMs = @(
        @{ Name = "WebServer01"; vCenter = "vcenter.lab.local" }
        @{ Name = "WebServer02"; vCenter = "vcenter.lab.local" }
    )
} | ConvertTo-Json | Out-File config.json

# Run bulk hardening
./scripts/bulk-hardening.ps1 -ConfigFile config.json
```

## Common Scenarios

### Production Environment
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "prod-vcenter.company.com" -VMName "ProdVM01" -Backup -LogPath "C:\Logs\hardening.log"
```

### Development Environment
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "dev-vcenter.lab.local" -VMName "DevVM01" -WhatIf
```

### Automated Deployment
```powershell
$cred = Get-Credential
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "AutoVM" -Credential $cred
```# Updated Sun Nov  9 12:49:54 CET 2025
