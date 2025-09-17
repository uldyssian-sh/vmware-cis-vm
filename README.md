# VMware CIS Virtual Machine Hardening

<div align="center">

```
┌─────────────────────────────────────────────────────────────┐
│                CIS VM Hardening Framework                   │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│  │   vCenter   │────│ CIS Audit   │────│ Compliance  │     │
│  │ Connection  │    │   Engine    │    │   Reports   │     │
│  └─────────────┘    └─────────────┘    └─────────────┘     │
│         │                   │                   │          │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│  │ Virtual     │    │ Security    │    │ Remediation │     │
│  │ Machines    │    │ Controls    │    │   Scripts   │     │
│  └─────────────┘    └─────────────┘    └─────────────┘     │
└─────────────────────────────────────────────────────────────┘
```
  
  [![CIS Benchmark](https://img.shields.io/badge/CIS-Benchmark-blue.svg)](https://www.cisecurity.org/cis-benchmarks/)
  [![VMware](https://img.shields.io/badge/VMware-vSphere-00A1C9.svg)](https://www.vmware.com/products/vsphere.html)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
</div>

## 🛡️ Overview

Automated CIS (Center for Internet Security) benchmark compliance tool for VMware virtual machines. Hardens VM configurations according to industry security standards.

## 🎯 Features

- **CIS Benchmark Compliance**: Automated security hardening
- **Multi-OS Support**: Windows and Linux virtual machines
- **Compliance Reporting**: Detailed security assessment reports
- **Remediation Scripts**: Automated fix deployment
- **Audit Logging**: Complete audit trail of changes

## 🚀 Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Configure vCenter connection
export VCENTER_HOST="vcenter.example.com"
export VCENTER_USER="administrator@vsphere.local"
export VCENTER_PASS="password"

# Run CIS compliance check
python cis_vm_audit.py --vm-name "production-vm-01" --report-format html

# Apply hardening
python cis_vm_harden.py --vm-name "production-vm-01" --apply-fixes
```

## 📚 Documentation

- [Installation Guide](https://github.com/uldyssian-sh/vmware-cis-vm/wiki/Installation)
- [CIS Controls Reference](https://github.com/uldyssian-sh/vmware-cis-vm/wiki/CIS-Controls)
- [Remediation Guide](https://github.com/uldyssian-sh/vmware-cis-vm/wiki/Remediation)

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.
