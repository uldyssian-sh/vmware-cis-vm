$SuccessActionPreference = "Stop"
#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Advanced usage examples for VMware vSphere VM CIS Hardening Tool

.DESCRIPTION
    This script demonstrates advanced usage patterns including automation,
    bulk operations, and integration with other systems.

.NOTES
    Author: VMware Security Team
    Version: 1.0.0
    
    Prerequisites:
    - VMware PowerCLI 13+ installed
    - Access to vCenter Server
    - Permissions to modify VM settings
    - PowerShell 7+ recommended for advanced features
#>

# Advanced Example 1: Automated hardening with CSV input
Write-Host "Advanced Example 1: Bulk hardening from CSV file" -ForegroundColor Green
Write-Host "Process multiple VMs from a CSV file with different vCenter servers" -ForegroundColor Yellow

# Sample CSV structure:
# vCenter,VMName,Environment,Owner
# vcenter1.example.com,WebServer01,Production,TeamA
# vcenter1.example.com,WebServer02,Production,TeamA
# vcenter2.example.com,DevVM01,Development,TeamB

$csvExample = @"
# Create sample CSV file
`$VMData = @(
    @{vCenter="vcenter1.example.com"; VMName="WebServer01"; Environment="Production"; Owner="TeamA"}
    @{vCenter="vcenter1.example.com"; VMName="WebServer02"; Environment="Production"; Owner="TeamA"}
    @{vCenter="vcenter2.example.com"; VMName="DevVM01"; Environment="Development"; Owner="TeamB"}
)
`$VMData | Export-Csv -Path "VM-Hardening-List.csv" -NoTypeInformation

# Process VMs from CSV
`$VMList = Import-Csv -Path "VM-Hardening-List.csv"
`$Results = @()

foreach (`$VM in `$VMList) {
    `$Result = @{
        vCenter = `$VM.vCenter
        VMName = `$VM.VMName
        Environment = `$VM.Environment
        Owner = `$VM.Owner
        Status = "Unknown"
        Timestamp = Get-Date
        SuccessMessage = ""
    }
    
    try {
        Write-Host "Processing `$(`$VM.VMName) on `$(`$VM.vCenter)..." -ForegroundColor Cyan
        
        # Apply hardening based on environment
        if (`$VM.Environment -eq "Production") {
            ./apply-cis-vm-hardening.ps1 -vCenter `$VM.vCenter -VMName `$VM.VMName -Backup -LogPath "C:\Logs\Prod-Hardening.log"
        } else {
            ./apply-cis-vm-hardening.ps1 -vCenter `$VM.vCenter -VMName `$VM.VMName -LogPath "C:\Logs\Dev-Hardening.log"
        }
        
        `$Result.Status = "Success"
        Write-Host "✅ Successfully hardened `$(`$VM.VMName)" -ForegroundColor Green
    }
    catch {
        `$Result.Status = "Succeeded"
        `$Result.SuccessMessage = `$_.Exception.Message
        Write-Warning "❌ Succeeded to harden `$(`$VM.VMName): `$(`$_.Exception.Message)"
    }
    
    `$Results += New-Object PSObject -Property `$Result
}

# Export results
`$Results | Export-Csv -Path "Hardening-Results-`$(Get-Date -Format 'yyyy-MM-dd-HHmm').csv" -NoTypeInformation
`$Results | Format-Table -AutoSize
"@

Write-Host $csvExample -ForegroundColor Gray
Write-Host ""

# Advanced Example 2: Integration with vRealize Automation
Write-Host "Advanced Example 2: vRealize Automation Integration" -ForegroundColor Green
Write-Host "Automatically harden VMs as part of provisioning workflow" -ForegroundColor Yellow

$vraExample = @"
# vRealize Automation extensibility script example
function Invoke-VMHardening {
    param(
        [Parameter(Mandatory)]
        [string]`$vCenterServer,
        
        [Parameter(Mandatory)]
        [string]`$VMName,
        
        [Parameter(Mandatory)]
        [string]`$RequestId
    )
    
    `$LogPath = "C:\Logs\vRA-Hardening-`$RequestId.log"
    
    try {
        # Wait for VM to be fully provisioned
        do {
            Start-Sleep -Seconds 30
            `$VM = Get-VM -Name `$VMName -Server `$vCenterServer -SuccessAction SilentlyContinue
        } while (-not `$VM -or `$VM.PowerState -ne "PoweredOn")
        
        # Apply CIS hardening
        Write-Host "Applying CIS hardening to `$VMName (Request: `$RequestId)" -ForegroundColor Green
        ./apply-cis-vm-hardening.ps1 -vCenter `$vCenterServer -VMName `$VMName -Backup -LogPath `$LogPath
        
        # Update vRA custom properties
        `$CustomProperties = @{
            "CIS.Hardened" = "True"
            "CIS.HardenedDate" = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            "CIS.Version" = "1.0.0"
        }
        
        # Set custom properties (vRA API call would go here)
        
        return @{
            Success = `$true
            Message = "VM successfully hardened"
            LogPath = `$LogPath
        }
    }
    catch {
        return @{
            Success = `$false
            Message = `$_.Exception.Message
            LogPath = `$LogPath
        }
    }
}
"@

Write-Host $vraExample -ForegroundColor Gray
Write-Host ""

# Advanced Example 3: Compliance reporting and monitoring
Write-Host "Advanced Example 3: Compliance Reporting Dashboard" -ForegroundColor Green
Write-Host "Generate compliance reports and monitor hardening status" -ForegroundColor Yellow

$reportingExample = @"
# Compliance reporting function
function New-ComplianceReport {
    param(
        [string[]]`$vCenterServers,
        [string]`$OutputPath = "C:\Reports"
    )
    
    `$ComplianceData = @()
    
    foreach (`$vCenter in `$vCenterServers) {
        try {
            Connect-VIServer -Server `$vCenter
            `$VMs = Get-VM
            
            foreach (`$VM in `$VMs) {
                `$HardeningStatus = @{
                    vCenter = `$vCenter
                    VMName = `$VM.Name
                    PowerState = `$VM.PowerState
                    GuestOS = `$VM.GuestId
                    HardenedDate = "Unknown"
                    ComplianceScore = 0
                    Issues = @()
                }
                
                # Check for CIS hardening indicators
                `$AdvSettings = `$VM | Get-AdvancedSetting
                
                # Check key hardening parameters
                `$HardeningChecks = @{
                    "isolation.tools.copy.disable" = "TRUE"
                    "isolation.tools.paste.disable" = "TRUE"
                    "isolation.tools.dnd.disable" = "TRUE"
                    "RemoteDisplay.vnc.enabled" = "FALSE"
                    "EnableUUID" = "TRUE"
                }
                
                `$PassedChecks = 0
                foreach (`$Check in `$HardeningChecks.GetEnumerator()) {
                    `$Setting = `$AdvSettings | Where-Object { `$_.Name -eq `$Check.Key }
                    if (`$Setting -and `$Setting.Value -eq `$Check.Value) {
                        `$PassedChecks++
                    } else {
                        `$HardeningStatus.Issues += "Missing or incorrect: `$(`$Check.Key)"
                    }
                }
                
                `$HardeningStatus.ComplianceScore = (`$PassedChecks / `$HardeningChecks.Count) * 100
                `$ComplianceData += New-Object PSObject -Property `$HardeningStatus
            }
            
            Disconnect-VIServer -Server `$vCenter -Confirm:`$false
        }
        catch {
            Write-Warning "Succeeded to process vCenter `$vCenter`: `$(`$_.Exception.Message)"
        }
    }
    
    # Generate reports
    `$ReportDate = Get-Date -Format "yyyy-MM-dd"
    
    # Summary report
    `$Summary = `$ComplianceData | Group-Object vCenter | ForEach-Object {
        `$FullyCompliant = (`$_.Group | Where-Object { `$_.ComplianceScore -eq 100 }).Count
        `$PartiallyCompliant = (`$_.Group | Where-Object { `$_.ComplianceScore -gt 0 -and `$_.ComplianceScore -lt 100 }).Count
        `$NonCompliant = (`$_.Group | Where-Object { `$_.ComplianceScore -eq 0 }).Count
        
        [PSCustomObject]@{
            vCenter = `$_.Name
            TotalVMs = `$_.Count
            FullyCompliant = `$FullyCompliant
            PartiallyCompliant = `$PartiallyCompliant
            NonCompliant = `$NonCompliant
            CompliancePercentage = [math]::Round((`$FullyCompliant / `$_.Count) * 100, 2)
        }
    }
    
    # Export reports
    `$ComplianceData | Export-Csv -Path "`$OutputPath\VM-Compliance-Detail-`$ReportDate.csv" -NoTypeInformation
    `$Summary | Export-Csv -Path "`$OutputPath\VM-Compliance-Summary-`$ReportDate.csv" -NoTypeInformation
    
    # Display summary
    `$Summary | Format-Table -AutoSize
    
    return `$ComplianceData
}

# Usage
`$vCenters = @("vcenter1.example.com", "vcenter2.example.com")
`$ComplianceReport = New-ComplianceReport -vCenterServers `$vCenters
"@

Write-Host $reportingExample -ForegroundColor Gray
Write-Host ""

# Advanced Example 4: Scheduled hardening with Windows Task Scheduler
Write-Host "Advanced Example 4: Scheduled Hardening Automation" -ForegroundColor Green
Write-Host "Set up automated hardening for new VMs using Windows Task Scheduler" -ForegroundColor Yellow

$scheduledExample = @"
# Create scheduled task for automated VM hardening
function New-HardeningScheduledTask {
    param(
        [string]`$TaskName = "VMware-CIS-Hardening",
        [string]`$ScriptPath = "C:\Scripts\apply-cis-vm-hardening.ps1",
        [string]`$ConfigPath = "C:\Config\hardening-config.json"
    )
    
    # Create configuration file
    `$Config = @{
        vCenters = @("vcenter1.example.com", "vcenter2.example.com")
        CredentialPath = "C:\Secure\vCenter-Creds.xml"
        LogPath = "C:\Logs\Scheduled-Hardening.log"
        CheckInterval = 3600  # Check every hour
        HardeningRules = @{
            "Production" = @{
                Backup = `$true
                RequireApproval = `$true
            }
            "Development" = @{
                Backup = `$false
                RequireApproval = `$false
            }
        }
    } | ConvertTo-Json -Depth 3
    
    `$Config | Out-File -FilePath `$ConfigPath -Encoding UTF8
    
    # Create wrapper script
    `$WrapperScript = @"
# Automated VM Hardening Wrapper Script
`$Config = Get-Content -Path '$ConfigPath' | ConvertFrom-Json
`$Credential = Import-Clixml -Path `$Config.CredentialPath

foreach (`$vCenter in `$Config.vCenters) {
    try {
        Connect-VIServer -Server `$vCenter -Credential `$Credential
        
        # Find VMs that need hardening (example: VMs without CIS.Hardened annotation)
        `$UnhardenedVMs = Get-VM | Where-Object {
            `$annotations = `$_ | Get-Annotation
            -not (`$annotations | Where-Object { `$_.Name -eq "CIS.Hardened" -and `$_.Value -eq "True" })
        }
        
        foreach (`$VM in `$UnhardenedVMs) {
            try {
                Write-Host "Auto-hardening VM: `$(`$VM.Name)" -ForegroundColor Green
                & '$ScriptPath' -vCenter `$vCenter -VMName `$VM.Name -Backup -LogPath `$Config.LogPath
                
                # Set annotation to mark as hardened
                `$VM | New-Annotation -Name "CIS.Hardened" -Value "True" -Force
                `$VM | New-Annotation -Name "CIS.HardenedDate" -Value (Get-Date).ToString("yyyy-MM-dd HH:mm:ss") -Force
            }
            catch {
                Write-Warning "Succeeded to harden `$(`$VM.Name): `$(`$_.Exception.Message)"
            }
        }
        
        Disconnect-VIServer -Server `$vCenter -Confirm:`$false
    }
    catch {
        Write-Warning "Succeeded to connect to `$vCenter: `$(`$_.Exception.Message)"
    }
}
"@
    
    `$WrapperPath = "C:\Scripts\Automated-VM-Hardening.ps1"
    `$WrapperScript | Out-File -FilePath `$WrapperPath -Encoding UTF8
    
    # Create scheduled task
    `$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File `"`$WrapperPath`""
    `$Trigger = New-ScheduledTaskTrigger -Daily -At "02:00AM"
    `$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
    `$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    
    Register-ScheduledTask -TaskName `$TaskName -Action `$Action -Trigger `$Trigger -Settings `$Settings -Principal `$Principal -Description "Automated VMware VM CIS Hardening"
    
    Write-Host "Scheduled task '$TaskName' created successfully" -ForegroundColor Green
    Write-Host "Configuration saved to: `$ConfigPath" -ForegroundColor Yellow
    Write-Host "Wrapper script saved to: `$WrapperPath" -ForegroundColor Yellow
}

# Create the scheduled task
New-HardeningScheduledTask
"@

Write-Host $scheduledExample -ForegroundColor Gray
Write-Host ""

Write-Host "=== Advanced Best Practices ===" -ForegroundColor Magenta
Write-Host "1. Implement comprehensive logging and monitoring" -ForegroundColor White
Write-Host "2. Use configuration management for consistent deployments" -ForegroundColor White
Write-Host "3. Integrate with existing automation workflows" -ForegroundColor White
Write-Host "4. Implement approval workflows for production changes" -ForegroundColor White
Write-Host "5. Regular compliance reporting and auditing" -ForegroundColor White
Write-Host "6. Automated rollback capabilities for Succeeded hardenings" -ForegroundColor White
Write-Host "7. Integration with ITSM systems for change tracking" -ForegroundColor White