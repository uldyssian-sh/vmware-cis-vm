# Complete Tutorial: VMware vSphere VM CIS Hardening

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Basic Usage](#basic-usage)
4. [Advanced Features](#advanced-features)
5. [Automation](#automation)
6. [Troubleshooting](#troubleshooting)

## Prerequisites

### System Requirements
- **PowerShell**: 7.0+ (recommended) or 5.1+
- **Operating System**: Windows, Linux, or macOS
- **Memory**: 512MB RAM minimum
- **Network**: Access to vCenter Server (port 443)

### VMware Requirements
- **vSphere**: Version 8.0+
- **PowerCLI**: Version 13.0+
- **Permissions**: VM configuration modification rights

## Installation

### Step 1: Install PowerShell (if needed)

**Windows:**
```powershell
winget install Microsoft.PowerShell
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
```

**macOS:**
```bash
brew install --cask powershell
```

### Step 2: Install VMware PowerCLI
```powershell
# Set PSGallery as trusted
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# Install PowerCLI
Install-Module VMware.PowerCLI -Scope CurrentUser -Force

# Verify installation
Get-Module VMware.PowerCLI -ListAvailable
```

### Step 3: Download the Tool
```bash
# Clone repository
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm

# Or download release
curl -L https://github.com/uldyssian-sh/vmware-cis-vm/releases/latest/download/vmware-cis-vm.zip -o vmware-cis-vm.zip
unzip vmware-cis-vm.zip
```

### Step 4: Configure PowerCLI
```powershell
# Disable CEIP participation
Set-PowerCLIConfiguration -ParticipateInCEIP $false -Confirm:$false

# Configure certificate handling (for lab environments)
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

# Set default server mode
Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -Confirm:$false
```

## Basic Usage

### Your First Hardening

1. **Preview Mode (Recommended First Step)**
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "TestVM" -WhatIf
```

2. **Basic Hardening**
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "TestVM"
```

3. **Hardening with Backup**
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "TestVM" -Backup
```

### Understanding the Output
```
Connecting to vCenter: vcenter.lab.local ...
Loading VM: TestVM ...
Applying hardening parameters...
Applying 'EnableUUID' = 'TRUE'
Applying 'isolation.tools.copy.disable' = 'TRUE'
Applying 'isolation.tools.paste.disable' = 'TRUE'
...
✅ Hardening applied successfully to VM 'TestVM'.
```

### Validation
```powershell
# Validate hardening was applied
./scripts/validate-hardening.ps1 -vCenter "vcenter.lab.local" -VMName "TestVM"
```

## Advanced Features

### Credential Management

**Option 1: Interactive Prompt (Default)**
```powershell
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM"
# Will prompt for username/password
```

**Option 2: Stored Credentials**
```powershell
# Store credentials securely (run once)
$cred = Get-Credential
$cred | Export-Clixml -Path "C:\Secure\vcenter-creds.xml"

# Use stored credentials
$storedCred = Import-Clixml -Path "C:\Secure\vcenter-creds.xml"
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM" -Credential $storedCred
```

### Bulk Operations

**Method 1: PowerShell Loop**
```powershell
$VMs = @("WebServer01", "WebServer02", "DBServer01")
$vCenter = "vcenter.example.com"

foreach ($VM in $VMs) {
    try {
        Write-Host "Processing $VM..." -ForegroundColor Green
        ./apply-cis-vm-hardening.ps1 -vCenter $vCenter -VMName $VM -Backup
        Write-Host "✅ $VM completed successfully" -ForegroundColor Green
    }
    catch {
        Write-Warning "❌ $VM failed: $($_.Exception.Message)"
    }
}
```

**Method 2: Configuration File**
```powershell
# Create configuration file
$config = @{
    VMs = @(
        @{ Name = "WebServer01"; vCenter = "vcenter1.example.com" }
        @{ Name = "WebServer02"; vCenter = "vcenter1.example.com" }
        @{ Name = "DBServer01"; vCenter = "vcenter2.example.com" }
    )
} | ConvertTo-Json

$config | Out-File "vm-config.json"

# Run bulk hardening
./scripts/bulk-hardening.ps1 -ConfigFile "vm-config.json"
```

### Custom Logging
```powershell
# Custom log location
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM" -LogPath "C:\Logs\hardening-$(Get-Date -Format 'yyyyMMdd').log"
```

## Automation

### Scheduled Hardening (Windows)
```powershell
# Create scheduled task for daily hardening check
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\Scripts\daily-hardening-check.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At "02:00AM"
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName "VMware-CIS-Hardening" -Action $action -Trigger $trigger -Settings $settings -Principal $principal
```

### CI/CD Integration

**GitHub Actions Example:**
```yaml
name: VM Hardening
on:
  workflow_dispatch:
    inputs:
      vm_name:
        description: 'VM Name to harden'
        required: true

jobs:
  harden:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Setup PowerShell
      shell: bash
      run: |
        sudo apt-get update
        sudo apt-get install -y powershell
    - name: Install PowerCLI
      shell: pwsh
      run: |
        Install-Module VMware.PowerCLI -Force
    - name: Harden VM
      shell: pwsh
      run: |
        ./apply-cis-vm-hardening.ps1 -vCenter ${{ secrets.VCENTER_SERVER }} -VMName ${{ github.event.inputs.vm_name }}
```

### Docker Usage
```bash
# Build container
docker build -t vmware-cis-vm .

# Run hardening
docker run -e VCENTER_SERVER=vcenter.example.com -e VM_NAME=MyVM vmware-cis-vm

# With custom configuration
docker run -v $(pwd)/config:/app/config -v $(pwd)/logs:/app/logs vmware-cis-vm -vCenter vcenter.example.com -VMName MyVM
```

## Production Deployment

### Best Practices Checklist

**Pre-Deployment:**
- [ ] Test in non-production environment
- [ ] Verify VM functionality after hardening
- [ ] Create VM snapshots or backups
- [ ] Document baseline configurations
- [ ] Obtain change approval

**During Deployment:**
- [ ] Use `-WhatIf` for preview
- [ ] Enable backup with `-Backup` parameter
- [ ] Monitor VM performance
- [ ] Validate hardening with validation script
- [ ] Document applied changes

**Post-Deployment:**
- [ ] Test VM functionality
- [ ] Monitor for issues
- [ ] Update compliance documentation
- [ ] Schedule regular compliance checks

### Production Script Example
```powershell
# Production hardening script with comprehensive error handling
param(
    [Parameter(Mandatory)]
    [string]$ConfigFile
)

$Config = Get-Content $ConfigFile | ConvertFrom-Json
$Results = @()
$LogPath = "C:\Logs\Production-Hardening-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

Start-Transcript -Path $LogPath

try {
    foreach ($VM in $Config.VMs) {
        $Result = @{
            VMName = $VM.Name
            vCenter = $VM.vCenter
            Status = "Unknown"
            StartTime = Get-Date
            EndTime = $null
            ErrorMessage = ""
        }

        try {
            Write-Host "Starting hardening for $($VM.Name)..." -ForegroundColor Cyan

            # Pre-hardening validation
            $PreCheck = ./scripts/validate-hardening.ps1 -vCenter $VM.vCenter -VMName $VM.Name
            Write-Host "Pre-hardening compliance: $($PreCheck.ComplianceScore)%" -ForegroundColor Yellow

            # Apply hardening
            ./apply-cis-vm-hardening.ps1 -vCenter $VM.vCenter -VMName $VM.Name -Backup -LogPath $LogPath

            # Post-hardening validation
            Start-Sleep -Seconds 10
            $PostCheck = ./scripts/validate-hardening.ps1 -vCenter $VM.vCenter -VMName $VM.Name
            Write-Host "Post-hardening compliance: $($PostCheck.ComplianceScore)%" -ForegroundColor Green

            $Result.Status = "Success"
            $Result.EndTime = Get-Date

            Write-Host "✅ Successfully hardened $($VM.Name)" -ForegroundColor Green
        }
        catch {
            $Result.Status = "Failed"
            $Result.ErrorMessage = $_.Exception.Message
            $Result.EndTime = Get-Date

            Write-Error "❌ Failed to harden $($VM.Name): $($_.Exception.Message)"
        }

        $Results += New-Object PSObject -Property $Result
    }

    # Generate summary report
    $Summary = @{
        TotalVMs = $Results.Count
        Successful = ($Results | Where-Object { $_.Status -eq "Success" }).Count
        Failed = ($Results | Where-Object { $_.Status -eq "Failed" }).Count
        ExecutionTime = (Get-Date) - $Results[0].StartTime
    }

    Write-Host "`n=== SUMMARY ===" -ForegroundColor Magenta
    Write-Host "Total VMs: $($Summary.TotalVMs)" -ForegroundColor White
    Write-Host "Successful: $($Summary.Successful)" -ForegroundColor Green
    Write-Host "Failed: $($Summary.Failed)" -ForegroundColor Red
    Write-Host "Execution Time: $($Summary.ExecutionTime)" -ForegroundColor White

    # Export detailed results
    $Results | Export-Csv -Path "C:\Reports\Hardening-Results-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv" -NoTypeInformation

    if ($Summary.Failed -eq 0) {
        Write-Host "`n🎉 All VMs hardened successfully!" -ForegroundColor Green
        exit 0
    } else {
        Write-Warning "`n⚠️ Some VMs failed hardening. Check logs for details."
        exit 1
    }
}
finally {
    Stop-Transcript
}
```

## Troubleshooting

### Common Issues and Solutions

**Issue: PowerCLI Module Not Found**
```powershell
# Solution
Install-Module VMware.PowerCLI -Force -AllowClobber
Import-Module VMware.PowerCLI
```

**Issue: Connection Timeout**
```powershell
# Solution: Increase timeout
Set-PowerCLIConfiguration -WebOperationTimeoutSeconds 300 -Confirm:$false
```

**Issue: VM Not Found**
```powershell
# Debug: List all VMs
Connect-VIServer -Server "vcenter.example.com"
Get-VM | Select-Object Name | Sort-Object Name
```

**Issue: Permission Denied**
```
Required vCenter permissions:
- Virtual Machine → Configuration → Modify device settings
- Virtual Machine → Configuration → Advanced configuration
- Virtual Machine → Configuration → Change Settings
```

### Debug Mode
```powershell
# Enable verbose output
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM" -Verbose -Debug
```

### Log Analysis
```powershell
# Check PowerCLI logs
Get-ChildItem "$env:APPDATA\VMware\vSphere PowerCLI\*.log" | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | Get-Content -Tail 50
```

## Next Steps

1. **Explore Advanced Features**: Review the [Advanced Scenarios](wiki/Advanced-Scenarios.md) wiki page
2. **Automate Operations**: Set up scheduled hardening for new VMs
3. **Monitor Compliance**: Implement regular compliance reporting
4. **Contribute**: Help improve the tool by reporting issues or contributing code
5. **Stay Updated**: Watch the repository for updates and new features

## Support Resources

- **Wiki**: [Complete documentation](wiki/Home.md)
- **Issues**: [Report bugs](https://github.com/uldyssian-sh/vmware-cis-vm/issues)
- **Discussions**: [Community Q&A](https://github.com/uldyssian-sh/vmware-cis-vm/discussions)
- **Releases**: [Latest versions](https://github.com/uldyssian-sh/vmware-cis-vm/releases)

---

**Congratulations!** You now have a comprehensive understanding of the VMware vSphere VM CIS Hardening Tool. Start with basic hardening in your lab environment, then gradually implement advanced features as your confidence grows.