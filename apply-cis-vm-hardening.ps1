<#
.SYNOPSIS
  CIS Hardening for vSphere Virtual Machines

.DESCRIPTION
  This PowerShell script applies VMware vSphere VM hardening parameters
  recommended by the Center for Internet Security (CIS).
  Fully compatible with PowerCLI 13+.

.PARAMETER vCenter
  The FQDN or IP of the vCenter Server to connect to.

.PARAMETER VMName
  The name of the Virtual Machine to which CIS hardening parameters should be applied.

.EXAMPLE
  .\apply-cis-vm-hardening.ps1 -vCenter "vcsa.lab.local" -VMName "Test-VM01"

.NOTES
  Author: Paladin alias LT
  Requirements:
    - VMware PowerCLI 13+ installed
    - Permissions to modify VM advanced settings
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$vCenter,

    [Parameter(Mandatory = $true)]
    [string]$VMName
)

# ============================================
#  Script created by Paladin alias LT
# ============================================

# Configure PowerCLI
Write-Host "Configuring PowerCLI..." -ForegroundColor Cyan
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

# Connect to vCenter
Write-Host "Connecting to vCenter: $vCenter ..." -ForegroundColor Cyan
Connect-VIServer -Server $vCenter

# Load VM
Write-Host "Loading VM: $VMName ..." -ForegroundColor Cyan
$vm = Get-VM -Name $VMName
if (-not $vm) {
    Write-Error "VM '$VMName' not found."
    exit 1
}

# Hardening parameters
$hardeningParams = @"
EnableUUID TRUE
isolation.bios.bbs.disable TRUE
isolation.device.connectable.disable TRUE
isolation.device.edit.disable TRUE
isolation.ghi.host.shellAction.disable TRUE
isolation.tools.copy.disable TRUE
isolation.tools.diskShrink.disable TRUE
isolation.tools.diskWiper.disable TRUE
isolation.tools.dispTopoRequest.disable TRUE
isolation.tools.dnd.disable TRUE
isolation.tools.getCreds.disable TRUE
isolation.tools.ghi.autologon.disable TRUE
isolation.tools.ghi.launchmenu.change TRUE
isolation.tools.ghi.protocolhandler.info.disable TRUE
isolation.tools.ghi.trayicon.disable TRUE
isolation.tools.guestDnDVersionSet.disable TRUE
isolation.tools.memSchedFakeSampleStats.disable TRUE
isolation.tools.paste.disable TRUE
isolation.tools.setGUIOptions.enable FALSE
isolation.tools.trashFolderState.disable TRUE
isolation.tools.unity.disable TRUE
isolation.tools.unity.push.update.disable TRUE
isolation.tools.unity.taskbar.disable TRUE
isolation.tools.unity.windowContents.disable TRUE
isolation.tools.unityActive.disable TRUE
isolation.tools.unityInterlockOperation.disable TRUE
isolation.tools.vmxDnDVersionGet.disable TRUE
log.keepOld 10
log.rotateSize 2048000
mks.enable3d FALSE
RemoteDisplay.maxConnections 1
RemoteDisplay.vnc.enabled FALSE
tools.guest.desktop.autolock TRUE
tools.guestlib.enableHostInfo FALSE
tools.setInfo.sizeLimit 1048576
devices.hotplug FALSE
"@ -split "`r?`n"

# Apply parameters via ExtensionData.ReconfigVM
Write-Host "Applying hardening parameters..." -ForegroundColor Cyan
$spec = New-Object VMware.Vim.VirtualMachineConfigSpec

foreach ($line in $hardeningParams) {
    if (-not [string]::IsNullOrWhiteSpace($line)) {
        $cols = $line -split "\s+"
        $key = $cols[0]
        $value = $cols[1]

        $opt = New-Object VMware.Vim.OptionValue
        $opt.Key = $key
        $opt.Value = $value
        $spec.ExtraConfig += $opt

        Write-Host "Applying '$key' = '$value'"
    }
}

# Apply configuration to VM
$vm.ExtensionData.ReconfigVM($spec)

Write-Host "✅ Hardening applied successfully to VM '$VMName'." -ForegroundColor Green

# Optional: Disconnect from vCenter
#Disconnect-VIServer -Server $vCenter -Confirm:$false
