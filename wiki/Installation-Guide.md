# Installation Guide

## Prerequisites
- PowerShell 7.0+
- VMware PowerCLI 13.0+
- vCenter Server access

## Quick Install
```powershell
# Install PowerCLI
Install-Module VMware.PowerCLI -Force

# Clone repository
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm

# Test installation
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "TestVM" -WhatIf
```

## Platform-Specific Setup

### Windows
```powershell
winget install Microsoft.PowerShell
Install-Module VMware.PowerCLI -Scope CurrentUser
```

### Linux
```bash
sudo snap install powershell --classic
pwsh -Command "Install-Module VMware.PowerCLI -Force"
```

### macOS
```bash
brew install --cask powershell
pwsh -Command "Install-Module VMware.PowerCLI -Force"
```

## Docker Installation
```bash
docker build -t vmware-cis-vm .
docker run -e VCENTER_SERVER=vcenter.example.com -e VM_NAME=MyVM vmware-cis-vm
```

## Verification
```powershell
Get-Module VMware.PowerCLI -ListAvailable
Test-Path ./apply-cis-vm-hardening.ps1
```# Updated 20251109_123814
# Updated Sun Nov  9 12:49:54 CET 2025
# Updated Sun Nov  9 12:52:26 CET 2025
# Updated Sun Nov  9 12:56:27 CET 2025
