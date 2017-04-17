. $PSScriptRoot\Shared.ps1

Describe "Module Manifest Tests PS$PSVersion" {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ENV:BHPSModuleManifest
        $? | Should Be $true
    }
}
