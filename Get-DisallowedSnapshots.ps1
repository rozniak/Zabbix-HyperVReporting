<#
    .SYNOPSIS
    This script is used for checking that there are no snapshots on certain VMs.

    .DESCRIPTION
    This script analyses a provided JSON file (configuration.json) located in the same
    folder in order to determine VMs that should not have any snapshots, and checks if
    any of them do.
    
    .EXAMPLE
    Get-DisallowedSnapshots.ps1

    .NOTES
    Author: Rory Fewell
    GitHub: https://github.com/rozniak
    Website: https://oddmatics.uk
#>

$curDir        = Split-Path -Parent $MyInvocation.MyCommand.Definition;
$configuration = Get-Content -Raw ($curDir + "\configuration.json") | ConvertFrom-Json;

# Check if any of the VMs have snapshots
#
$dirtyVMs = New-Object -TypeName "System.Collections.Generic.List[string]";

foreach ($vmName in $configuration.DisallowSnapshots)
{
    try
    {
        $snapCount = (Get-VM -Name $vmName -ErrorAction Stop | Get-VMSnapshot).Length;

        if ($snapCount -gt 0)
        {
            $dirtyVMs.Add($vmName);
        }
    }
    catch
    {
        continue;
    }
}

return $dirtyVMs -join ", ";
