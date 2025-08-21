# VMware CIS VM Hardening

![VMware](https://img.shields.io/badge/VMware-vSphere-blue) ![PowerCLI](https://img.shields.io/badge/PowerCLI-13%2B-brightgreen)

**Secure your vSphere Virtual Machines quickly and efficiently.**  
This repository provides a PowerShell script that applies **CIS (Center for Internet Security) recommended hardening settings** to VMware vSphere VMs. Perfect for administrators who want to enforce best practices and improve VM security with minimal effort.

---

## Repository

- **Repository name:** `vmware-cis-vm`
- **Script:** `apply-cis-vm-hardening.ps1`
- **Author:** [uldyssian-sh](https://github.com/uldyssian-sh)

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
