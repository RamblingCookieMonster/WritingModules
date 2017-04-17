@{
    # Some defaults for all dependencies
    PSDependOptions = @{
        Target = '$ENV:USERPROFILE\Documents\WindowsPowerShell\Modules'
        AddToPath = $True
    }

    # Grab some modules without depending on PowerShellGet
    'InvokeBuild' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '3.3.3'
    }
    'PSDeploy' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '0.1.27'
    }
    'BuildHelpers' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '0.0.44'
    }
    'Pester' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '4.0.3'
    }
    'PSScriptAnalyzer' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '1.11.1'
    }
    'platyPS' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '0.7.6'
    }
}