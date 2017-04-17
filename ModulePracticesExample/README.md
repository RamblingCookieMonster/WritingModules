# <%=$PLASTER_PARAM_ModuleName%>

<%=$PLASTER_PARAM_ModuleDesc%>

## Getting Started

```powershell
# One time setup
    # Download the repository
    # Unblock the zip
    # Extract the <%=$PLASTER_PARAM_ModuleName%> folder to a module path (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)

    #Simple alternative, if you have PowerShell 5, or the PowerShellGet module:
        Install-Module <%=$PLASTER_PARAM_ModuleName%>

# Import the module.
    Import-Module <%=$PLASTER_PARAM_ModuleName%>

# Get commands in the module
    Get-Command -Module <%=$PLASTER_PARAM_ModuleName%>

# Get help
    Get-Help about_<%=$PLASTER_PARAM_ModuleName%>
```
