# Advanced Scenarios

## Enterprise Automation

### vRealize Automation Integration
```powershell
# Post-provisioning hardening
function Invoke-PostProvisionHardening {
    param($VMName, $vCenter, $RequestId)

    # Wait for VM readiness
    do {
        Start-Sleep 30
        $VM = Get-VM -Name $VMName -ErrorAction SilentlyContinue
    } while (-not $VM -or $VM.PowerState -ne "PoweredOn")

    # Apply hardening
    ./apply-cis-vm-hardening.ps1 -vCenter $vCenter -VMName $VMName -Backup

    # Update custom properties
    Set-Annotation -Entity $VM -Name "CIS.Hardened" -Value "True"
}
```

### CI/CD Pipeline Integration
```yaml
# Azure DevOps Pipeline
- task: PowerShell@2
  displayName: 'Harden VMs'
  inputs:
    targetType: 'inline'
    script: |
      ./apply-cis-vm-hardening.ps1 -vCenter $(vCenterServer) -VMName $(VMName) -Backup
```

## Compliance Reporting

### Generate Compliance Report
```powershell
function New-ComplianceReport {
    param($vCenterServers, $OutputPath)

    $Results = @()
    foreach ($vCenter in $vCenterServers) {
        Connect-VIServer $vCenter
        $VMs = Get-VM

        foreach ($VM in $VMs) {
            $Settings = $VM | Get-AdvancedSetting
            $Score = Test-CISCompliance -Settings $Settings

            $Results += [PSCustomObject]@{
                vCenter = $vCenter
                VMName = $VM.Name
                ComplianceScore = $Score
                LastChecked = Get-Date
            }
        }
    }

    $Results | Export-Csv "$OutputPath\compliance-$(Get-Date -Format 'yyyyMMdd').csv"
    return $Results
}
```

### Scheduled Compliance Monitoring
```powershell
# Windows Task Scheduler
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\Scripts\compliance-check.ps1"
$Trigger = New-ScheduledTaskTrigger -Daily -At "02:00AM"
Register-ScheduledTask -TaskName "VM-Compliance-Check" -Action $Action -Trigger $Trigger
```

## Multi-Tenant Environments

### Tenant-Specific Hardening
```powershell
$TenantConfig = @{
    "TenantA" = @{
        vCenter = "vcenter-a.example.com"
        HardeningLevel = "High"
        BackupRequired = $true
    }
    "TenantB" = @{
        vCenter = "vcenter-b.example.com"
        HardeningLevel = "Medium"
        BackupRequired = $false
    }
}

foreach ($Tenant in $TenantConfig.GetEnumerator()) {
    $Config = $Tenant.Value
    $VMs = Get-VM -Server $Config.vCenter

    foreach ($VM in $VMs) {
        if ($Config.BackupRequired) {
            ./apply-cis-vm-hardening.ps1 -vCenter $Config.vCenter -VMName $VM.Name -Backup
        } else {
            ./apply-cis-vm-hardening.ps1 -vCenter $Config.vCenter -VMName $VM.Name
        }
    }
}
```

## Disaster Recovery

### Configuration Backup
```powershell
function Backup-VMConfiguration {
    param($VMName, $vCenter, $BackupPath)

    $VM = Get-VM -Name $VMName -Server $vCenter
    $Settings = $VM | Get-AdvancedSetting

    $Backup = @{
        VMName = $VMName
        Timestamp = Get-Date
        Settings = $Settings | ForEach-Object { @{ Name = $_.Name; Value = $_.Value } }
    }

    $Backup | ConvertTo-Json -Depth 3 | Out-File "$BackupPath\$VMName-$(Get-Date -Format 'yyyyMMdd-HHmmss').json"
}
```

### Configuration Restore
```powershell
function Restore-VMConfiguration {
    param($BackupFile, $vCenter)

    $Backup = Get-Content $BackupFile | ConvertFrom-Json
    $VM = Get-VM -Name $Backup.VMName -Server $vCenter

    foreach ($Setting in $Backup.Settings) {
        $VM | New-AdvancedSetting -Name $Setting.Name -Value $Setting.Value -Force
    }
}
```

## Performance Optimization

### Parallel Processing
```powershell
$VMs = Get-VM | Select-Object -First 20
$VMs | ForEach-Object -Parallel {
    ./apply-cis-vm-hardening.ps1 -vCenter $using:vCenter -VMName $_.Name
} -ThrottleLimit 5
```

### Batch Operations
```powershell
# Process VMs in batches of 10
$AllVMs = Get-VM
$BatchSize = 10

for ($i = 0; $i -lt $AllVMs.Count; $i += $BatchSize) {
    $Batch = $AllVMs[$i..($i + $BatchSize - 1)]

    foreach ($VM in $Batch) {
        Start-Job -ScriptBlock {
            param($VMName, $vCenter)
            ./apply-cis-vm-hardening.ps1 -vCenter $vCenter -VMName $VMName
        } -ArgumentList $VM.Name, $vCenter
    }

    # Wait for batch completion
    Get-Job | Wait-Job | Remove-Job
}
```# Updated 20251109_123814
# Updated Sun Nov  9 12:49:54 CET 2025
# Updated Sun Nov  9 12:52:26 CET 2025
