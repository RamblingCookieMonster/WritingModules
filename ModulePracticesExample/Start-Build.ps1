<#
    .SYNOPSIS
        Kick off a build

    .DESCRIPTION
        Kick off a build

        Installs PSDepend, pulls down requirements, invokes build file

    .PARAM Task
        Build task to run.  Defaults to Test.

    .PARAM Environment
        Used to pick tags for things like PSDeploy.

        Local or AppVeyor.  Local is the default

    .PARAM NoClean
        Whether to clean up the BuildOutput folder, and the tests and module underneath it

#>
[cmdletbinding()]
param(
    [ValidateSet('Test', 'Clean', 'Build', 'Deploy')]
    [string]$Task = 'Test',
    [string]$Environment = 'Local',
    [string]$BuildOutput = "$PSScriptRoot\BuildOutput",
    [bool]$NoClean = $True
)

# Bootstrap PSDepend for other dependencies
if(-not (Get-Module -ListAvailable PSDepend))
{
    & (Resolve-Path "$PSScriptRoot\Build\helpers\Install-PSDepend.ps1")
}
Import-Module PSDepend
$null = Invoke-PSDepend -Path "$PSScriptRoot\Build\requirements.psd1" -Install -Import -Force -Target "$BuildOutput/dependencies"

# Kick off the build
Invoke-Build -File $PSScriptRoot\Build\build.ps1 -Task $Task -NoClean:$NoClean -Environment $Environment -BuildOutput $BuildOutput
