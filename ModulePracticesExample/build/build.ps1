<#
    .Synopsis
    Build script (https://github.com/nightroman/Invoke-Build)

    .Description
    Hah
#>
param (
    [bool]$NoClean = $True,
    [string]$Environment = 'Local',
    [string]$BuildOutput
)

Set-BuildEnvironment -BuildOutput $BuildOutput -Path "$PSScriptRoot\.." -Force
if($ENV:BHProjectPath)
{
    $ProjectRoot = $ENV:BHProjectPath
    $BuildOutput = $ENV:BHBuildOutput
    "Build variables:" | Out-Host
    Get-Item ENV:BH* | Out-Host
}
else
{
    $ProjectRoot = ( Resolve-Path "$PSScriptRoot/.." ).Path
    if(-not $BuildOutput)
    {
        $BuildOutput = Join-Path $ProjectRoot BuildOutput
    }
}
$PesterOutput = Join-Path $BuildOutput Pester

$lines = '----------------'

$Verbose = @{}
if($ENV:BHCommitMessage -match "!verbose")
{
    $Verbose = @{Verbose = $True}
}

# Runs tests, returns path of test output files
function Invoke-Tests {
    [cmdletbinding()]
    param(
        $TestPath,
        $PesterOutput = $PesterOutput
    )
    $PSVersion = $PSVersionTable.PSVersion.Major
    "`n`tSTATUS: Testing with PowerShell $PSVersion"

    # Gather test results. Store them in a variable and file
    $Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
    $TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
    $TestResults = Invoke-Pester -Path $TestPath -PassThru -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile"

    # In Appveyor?  Upload our tests! #Abstract this into a function?
    If($ENV:BHBuildSystem -eq 'AppVeyor')
    {
        Add-TestResultToAppveyor -TestFile "$ProjectRoot\$TestFile"
    }

    # Failed tests?
    # Need to tell psake or it will proceed to the deployment. Danger!
    if($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
} # Invoke-Tests

# Default task is 'deploy'
Task . Test

Task Init {
    $lines
    Set-Location $ProjectRoot
    $null = mkdir $BuildOutput -force
    if ($Verbose.Verbose)
    {
        Get-BuildEnvironmentDetail -KillKittens
    }
    "`n"
}

Task Clean {
    if(-not $NoClean)
    {
        Remove-Item $BuildOutput -Force -Recurse -ErrorAction SilentlyContinue
    }
}

Task Build {
    $lines
    Invoke-PSDeploy -Path $ProjectRoot\Build -Force $true -Tags 'Build'
    Set-ModuleFunctions -Name $ENV:BHBuildOutput\$ENV:BHProjectName

    # Bump the module version
    Try
    {
        $Version = Get-NextPSGalleryVersion -Name $env:BHProjectName -ErrorAction Stop
        #TODO: If Version is less than current, skip
        Update-Metadata -Path $ENV:BHBuildOutput\$ENV:BHProjectName\$ENV:BHProjectName.psd1 -PropertyName ModuleVersion -Value $Version -ErrorAction stop
    }
    Catch
    {
        "Failed to update version for '$env:BHProjectName': $_.`nContinuing with existing version"
    }
}

Task Test Init, Build, {
    $lines
    Invoke-Tests -TestPath $ProjectRoot\Test\ -PesterOutput $BuildOutput
    "`n"
}, Clean

Task Deploy Init, Build, Test, {
    $lines

    $SkipNotice = "Deploying items tagged [$Tag]" +
    "    `$ENV:APPVEYOR_PROJECT_NAME:            $ENV:APPVEYOR_PROJECT_NAME" +
    "    `$ENV:BHBuildSystem -eq 'AppVeyor':     $($ENV:BHBuildSystem -eq 'AppVeyor')" +
    "    `$ENV:BHBranchName -eq 'master':        $($ENV:BHBranchName -eq "master")" +
    "    `$ENV:BHCommitMessage -match '!deploy': $($ENV:BHCommitMessage -match '!deploy')"

    if ( $ENV:APPVEYOR_PROJECT_NAME )
    {
        $Tag = 'AppVeyor'
        if(
            $ENV:BHBuildSystem -eq 'AppVeyor' -and # you might gate deployments to your build system
            $ENV:BHBranchName -eq "master" -and    # you might have another deployment for dev, or use tagged deployments based on branch
            $ENV:BHCommitMessage -match '!deploy'  # you might add a trigger via commit message
        )
        {
            $Tag = 'AppVeyor-Deploy'
        }
        else
        {
            $Tag = 'AppVeyor'
            $SkipNotice
        }

    }
    else
    {
        $Tag = 'Local'
        $SkipNotice
    }

    $Params = @{
        Path = $ProjectRoot
        Force = $true
        Tags = $Tag
    }
    $DeployOutput = Invoke-PSDeploy @Verbose @Params
    if ($Verbose.Verbose)
    {
        $DeployOutput
    }

    "`n"
}, Clean