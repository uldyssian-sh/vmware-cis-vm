BeforeAll {
    # Import the main script for testing
    $ScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "apply-cis-vm-hardening.ps1"
}

Describe "VMware CIS VM Hardening Script Tests" {
    
    Context "Parameter Validation" {
        It "Should require vCenter parameter" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match '\[Parameter\(Mandatory\s*=\s*\$true\)\].*\$vCenter'
        }
        
        It "Should require VMName parameter" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match '\[Parameter\(Mandatory\s*=\s*\$true\)\].*\$VMName'
        }
    }
    
    Context "Hardening Parameters" {
        It "Should contain CIS recommended isolation settings" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            
            $ScriptContent | Should -Match "isolation\.tools\.copy\.disable"
            $ScriptContent | Should -Match "isolation\.tools\.paste\.disable"
            $ScriptContent | Should -Match "isolation\.tools\.dnd\.disable"
            $ScriptContent | Should -Match "isolation\.device\.connectable\.disable"
        }
        
        It "Should disable VNC by default" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "RemoteDisplay\.vnc\.enabled\s+FALSE"
        }
        
        It "Should enable UUID generation" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "EnableUUID\s+TRUE"
        }
        
        It "Should configure logging parameters" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "log\.keepOld"
            $ScriptContent | Should -Match "log\.rotateSize"
        }
        
        It "Should disable hotplug devices" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "devices\.hotplug\s+FALSE"
        }
    }
    
    Context "Security Validation" {
        It "Should not contain hardcoded credentials" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            
            $ScriptContent | Should -Not -Match "password\s*=\s*['\"][^'\"]+['\"]"
            $ScriptContent | Should -Not -Match "username\s*=\s*['\"][^'\"]+['\"]"
            $ScriptContent | Should -Not -Match "secret\s*=\s*['\"][^'\"]+['\"]"
        }
        
        It "Should use secure PowerCLI configuration" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "Set-PowerCLIConfiguration.*InvalidCertificateAction.*Ignore"
        }
    }
    
    Context "Script Structure" {
        It "Should contain help documentation" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "\.SYNOPSIS"
            $ScriptContent | Should -Match "\.DESCRIPTION"
            $ScriptContent | Should -Match "\.PARAMETER"
            $ScriptContent | Should -Match "\.EXAMPLE"
        }
        
        It "Should have error handling" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "if.*-not.*\$vm"
            $ScriptContent | Should -Match "Write-Error"
        }
    }
    
    Context "VMware Integration" {
        It "Should use ExtensionData.ReconfigVM method" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "ExtensionData\.ReconfigVM"
        }
        
        It "Should create VirtualMachineConfigSpec" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "VMware\.Vim\.VirtualMachineConfigSpec"
        }
        
        It "Should create OptionValue objects" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "VMware\.Vim\.OptionValue"
        }
    }
    
    Context "Output and Logging" {
        It "Should provide user feedback" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "Write-Host.*Connecting"
            $ScriptContent | Should -Match "Write-Host.*Loading"
            $ScriptContent | Should -Match "Write-Host.*Applying"
        }
        
        It "Should show success message" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "Hardening applied successfully"
        }
    }
}# Updated 20251109_123814
# Updated Sun Nov  9 12:52:26 CET 2025
