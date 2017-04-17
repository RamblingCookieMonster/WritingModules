# Assumption: You're in the module root. Not using $PSScriptRoot for something meant to be interactive

# Define module name and some path to put it, clean this out
$ModuleName = 'SampleModule'
$ModuleOutput = "C:\modules\$ModuleName"
Remove-Item $ModuleOutput -Recurse -Force -ErrorAction SilentlyContinue

# Invoke Plaster against this template
Invoke-Plaster -TemplatePath (Join-Path $PWD.Path "\ModulePracticesExample") `
               -DestinationPath $ModuleOutput `
               -ModuleName $ModuleName `
               -ModuleDesc "This module does nothing!" `
               -License MIT `
               -Version 0.0.1 `
               -FullName "Warren Frame" `
               -Editor VSCode

# View the resulting module scaffolding
cd $ModuleOutput
dir

# View the resulting module (it's missing help that would be built by platyps in a CI/CD environment)
dir $ModuleOutput\$ModuleName

# Invoke a build - this pulls down PSDepend, resolves dependencies, and runs Invoke-Build against \build\build.ps1
.\Start-Build.ps1

# View the resulting module
dir $ModuleOutput\BuildOutput\$Modulename

# NOTE: This was just an experimental module design to illustrate Plaster use.
#       It has some ideas you could take away, but needs work.