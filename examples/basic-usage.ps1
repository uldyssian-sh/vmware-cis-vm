#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Basic usage examples for VMware vSphere VM CIS Hardening Tool

.DESCRIPTION
    This script demonstrates basic usage patterns for the CIS hardening tool.
    These examples show common scenarios and best practices.

.NOTES
    Author: VMware Security Team
    Version: 1.0.0
    
    Prerequisites:
    - VMware PowerCLI 13+ installed
    - Access to vCenter Server
    - Permissions to modify VM settings
#>

# Example 1: Basic hardening with credential prompt
Write-Host "Example 1: Basic VM hardening" -ForegroundColor Green
Write-Host "This will prompt for vCenter credentials and apply CIS hardening to a single VM" -ForegroundColor Yellow

$vCenterServer = "vcenter.example.com"
$VMName = "WebServer01"

# Apply hardening (will prompt for credentials)
# ./apply-cis-vm-hardening.ps1 -vCenter $vCenterServer -VMName $VMName

Write-Host ""
Write-Host "Command: ./apply-cis-vm-hardening.ps1 -vCenter '$vCenterServer' -VMName '$VMName'" -ForegroundColor Cyan
Write-Host ""

# Example 2: Hardening with stored credentials
Write-Host "Example 2: Using stored credentials" -ForegroundColor Green
Write-Host "This example shows how to use pre-stored credentials for automation" -ForegroundColor Yellow

# Store credentials securely (run this once)
# $credential = Get-Credential
# $credential | Export-Clixml -Path "C:\Secure\vCenter-Creds.xml"

# Use stored credentials
# $storedCred = Import-Clixml -Path "C:\Secure\vCenter-Creds.xml"
# ./apply-cis-vm-hardening.ps1 -vCenter $vCenterServer -VMName $VMName -Credential $storedCred

Write-Host ""
Write-Host "Commands:" -ForegroundColor Cyan
Write-Host "`$credential = Get-Credential" -ForegroundColor Gray
Write-Host "`$credential | Export-Clixml -Path 'C:\Secure\vCenter-Creds.xml'" -ForegroundColor Gray
Write-Host "`$storedCred = Import-Clixml -Path 'C:\Secure\vCenter-Creds.xml'" -ForegroundColor Gray
Write-Host "./apply-cis-vm-hardening.ps1 -vCenter '$vCenterServer' -VMName '$VMName' -Credential `$storedCred" -ForegroundColor Gray
Write-Host ""

# Example 3: Preview mode (WhatIf)
Write-Host "Example 3: Preview changes without applying them" -ForegroundColor Green
Write-Host "Use -WhatIf to see what changes would be made without actually applying them" -ForegroundColor Yellow

# Preview changes
# ./apply-cis-vm-hardening.ps1 -vCenter $vCenterServer -VMName $VMName -WhatIf

Write-Host ""
Write-Host "Command: ./apply-cis-vm-hardening.ps1 -vCenter '$vCenterServer' -VMName '$VMName' -WhatIf" -ForegroundColor Cyan
Write-Host ""

# Example 4: Hardening with backup
Write-Host "Example 4: Create backup before hardening" -ForegroundColor Green
Write-Host "Always recommended for production environments" -ForegroundColor Yellow

# Apply hardening with backup
# ./apply-cis-vm-hardening.ps1 -vCenter $vCenterServer -VMName $VMName -Backup

Write-Host ""
Write-Host "Command: ./apply-cis-vm-hardening.ps1 -vCenter '$vCenterServer' -VMName '$VMName' -Backup" -ForegroundColor Cyan
Write-Host ""

# Example 5: Multiple VMs with error handling
Write-Host "Example 5: Hardening multiple VMs with error handling" -ForegroundColor Green
Write-Host "Production-ready script for multiple VM hardening" -ForegroundColor Yellow

$VMList = @("WebServer01", "WebServer02", "DBServer01", "AppServer01")

Write-Host ""
Write-Host "Script example:" -ForegroundColor Cyan
Write-Host @"
`$VMList = @("WebServer01", "WebServer02", "DBServer01", "AppServer01")
`$vCenter = "vcenter.example.com"
`$SuccessCount = 0
`$FailureCount = 0

foreach (`$VM in `$VMList) {
    try {
        Write-Host "Hardening VM: `$VM" -ForegroundColor Green
        ./apply-cis-vm-hardening.ps1 -vCenter `$vCenter -VMName `$VM -Backup -ErrorAction Stop
        `$SuccessCount++
        Write-Host "✅ Successfully hardened `$VM" -ForegroundColor Green
    }
    catch {
        `$FailureCount++
        Write-Warning "❌ Failed to harden `$VM`: `$(`$_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "Summary: `$SuccessCount successful, `$FailureCount failed" -ForegroundColor Yellow
"@ -ForegroundColor Gray

Write-Host ""

# Example 6: Custom logging
Write-Host "Example 6: Custom logging location" -ForegroundColor Green
Write-Host "Specify custom log file location for audit trails" -ForegroundColor Yellow

$LogPath = "C:\Logs\VM-Hardening-$(Get-Date -Format 'yyyy-MM-dd').log"

Write-Host ""
Write-Host "Command: ./apply-cis-vm-hardening.ps1 -vCenter '$vCenterServer' -VMName '$VMName' -LogPath '$LogPath'" -ForegroundColor Cyan
Write-Host ""

Write-Host "=== Best Practices ===" -ForegroundColor Magenta
Write-Host "1. Always test in non-production environment first" -ForegroundColor White
Write-Host "2. Use -WhatIf to preview changes" -ForegroundColor White
Write-Host "3. Create backups with -Backup parameter" -ForegroundColor White
Write-Host "4. Store credentials securely" -ForegroundColor White
Write-Host "5. Implement proper error handling for automation" -ForegroundColor White
Write-Host "6. Keep audit logs of all hardening activities" -ForegroundColor White
Write-Host "7. Verify VM functionality after hardening" -ForegroundColor White