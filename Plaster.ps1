$ModuleName = 'SampleModule'
$ModuleOutput = "C:\modules\$ModuleName"
Remove-Item $ModuleOutput -Recurse -Force -ErrorAction SilentlyContinue

Invoke-Plaster -TemplatePath "~\Documents\GitHub\WritingModules\ModulePracticesExample" `
               -DestinationPath $ModuleOutput `
               -ModuleName $ModuleName `
               -ModuleDesc "This module does nothing!" `
               -License MIT `
               -Version 0.0.1 `
               -FullName "Warren Frame" `
               -Editor VSCode

cd $ModuleOutput
dir

dir $ModuleOutput\$ModuleName
.\Start-Build.ps1 -Verbose

dir $ModuleOutput\BuildOutput\$Modulename