BeforeAll {
    $ScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "apply-cis-vm-hardening.ps1"
}

Describe "Full Hardening Integration Tests" {
    
    Context "Script Execution" {
        It "Should execute without syntax errors" {
            $Errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize((Get-Content $ScriptPath -Raw), [ref]$Errors)
            $Errors | Should -BeNullOrEmpty
        }
        
        It "Should have all required parameters" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "param\s*\("
            $ScriptContent | Should -Match "\[Parameter\(Mandatory\s*=\s*\$true\)\].*vCenter"
            $ScriptContent | Should -Match "\[Parameter\(Mandatory\s*=\s*\$true\)\].*VMName"
        }
    }
    
    Context "Hardening Parameters Validation" {
        It "Should contain all CIS hardening settings" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            
            $RequiredSettings = @(
                "EnableUUID",
                "isolation.bios.bbs.disable",
                "isolation.device.connectable.disable",
                "isolation.tools.copy.disable",
                "isolation.tools.paste.disable",
                "isolation.tools.dnd.disable",
                "RemoteDisplay.vnc.enabled",
                "log.keepOld",
                "devices.hotplug"
            )
            
            foreach ($Setting in $RequiredSettings) {
                $ScriptContent | Should -Match [regex]::Escape($Setting)
            }
        }
        
        It "Should have correct parameter values" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Match "EnableUUID\s+TRUE"
            $ScriptContent | Should -Match "RemoteDisplay\.vnc\.enabled\s+FALSE"
            $ScriptContent | Should -Match "devices\.hotplug\s+FALSE"
        }
    }
    
    Context "Security Compliance" {
        It "Should not contain hardcoded credentials" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Not -Match "password\s*=\s*['\"][^'\"]*['\"]"
            $ScriptContent | Should -Not -Match "username\s*=\s*['\"][^'\"]*['\"]"
        }
        
        It "Should not contain personal information" {
            $ScriptContent = Get-Content $ScriptPath -Raw
            $ScriptContent | Should -Not -Match "lubomir|tobek"
        }
    }
}