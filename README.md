# VMware CIS VM Hardening

![VMware](https://img.shields.io/badge/VMware-vSphere-blue) ![PowerCLI](https://img.shields.io/badge/PowerCLI-13%2B-brightgreen)

**Secure your vSphere Virtual Machines quickly and efficiently.**  
This repository provides a PowerShell script that applies **CIS (Center for Internet Security) recommended hardening settings** to VMware vSphere VMs. Perfect for administrators who want to enforce best practices and improve VM security with minimal effort.

---

## Repository

- **Repository name:** `vmware-cis-vm`
- **Script:** `apply-cis-vm-hardening.ps1`
- **Author:** `LT`
- **Version:** `1.0`

---

## Disclaimer

This script is provided **"as is"**, without any warranty of any kind. Use it at your own risk. You are solely responsible for reviewing, testing, and implementing it in your own environment.

---


## Overview

The `apply-cis-vm-hardening.ps1` script applies multiple advanced VM settings recommended by CIS, including:

- Disabling unnecessary guest operations
- Limiting remote display and VNC connections
- Enforcing logging and rotation policies
- Controlling device hotplug options
- Applying several VMware Tools isolation settings

All settings are applied via `ExtensionData.ReconfigVM()`, ensuring **full compatibility with PowerCLI 13+**.

---

## Features

- Single script applies **all CIS VM hardening parameters**
- Easy to use with any VM in your vCenter
- Clear console output showing applied settings
- No external dependencies
- Compatible with PowerCLI 13+

---

## Requirements

- VMware PowerCLI 13+ installed
- Access and permissions to modify VM advanced settings
- Access to a vCenter Server

---

## Usage

1. **Clone the repository:**

```powershell
git clone https://github.com/uldyssian-sh/vmware-cis-vm.git
cd vmware-cis-vm

Run the script:
.\apply-cis-vm-hardening.ps1 -vCenter "vcsa.lab.local" -VMName "Test-VM01"

Script actions:
* Connects to the specified vCenter
* Loads the specified VM
* Applies all CIS hardening parameters
* Outputs each applied setting
* Confirms completion with a success message

---

Example Output
Connecting to vCenter: vcsa.lab.local ...
Loading VM: Test-VM01 ...
Applying hardening parameters...
Applying 'EnableUUID' = 'TRUE'
Applying 'isolation.bios.bbs.disable' = 'TRUE'
Applying 'RemoteDisplay.maxConnections' = '1'
...
✅ Hardening applied successfully to VM 'Test-VM01'.
