# Installation Guide

## Quick Install

```powershell
# Install PowerCLI
Install-Module VMware.PowerCLI -Force

# Clone repository
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm

# Run hardening
./apply-cis-vm-hardening.ps1 -vCenter "vcenter.example.com" -VMName "MyVM"
```

## System Requirements

- PowerShell 7.0+
- VMware PowerCLI 13.0+
- vCenter Server access
- VM modification permissions

## Detailed Setup

### 1. PowerShell Installation

**Windows:**
```powershell
winget install Microsoft.PowerShell
```

**Linux:**
```bash
sudo snap install powershell --classic
```

**macOS:**
```bash
brew install --cask powershell
```

### 2. PowerCLI Installation

```powershell
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module VMware.PowerCLI -Scope CurrentUser
```

### 3. Configuration

```powershell
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -ParticipateInCEIP $false -Confirm:$false
```

## Verification

```powershell
Get-Module VMware.PowerCLI -ListAvailable
```# Updated Sun Nov  9 12:49:54 CET 2025
# Updated Sun Nov  9 12:52:26 CET 2025
# Updated Sun Nov  9 12:56:27 CET 2025
