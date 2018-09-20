<#
    .SYNOPSIS
    This script is used for checking that all VMs marked "critical" are available and
    running.

    .DESCRIPTION
    This script analyses a provided JSON file (configuration.json) located in the same
    folder in order to determine VMs that are considered "critical", and then verifies
    that these VMs are all available and running.
    
    .EXAMPLE
    Get-VMCriticalCount.ps1

    .NOTES
    Author: Rory Fewell
    GitHub: https://github.com/rozniak
    Website: https://oddmatics.uk
#>

$curDir = Split-Path -Parent $MyInvocation.MyCommand.Definition;
$configuration = Get-Content -Raw ($curDir + "\configuration.json") | ConvertFrom-Json;

# Check all critical VMs are accounted for
#
for ($i = 0; $i -lt $configuration.CriticalVMs.Length; $i++)
{
    $vmName = $configuration.CriticalVMs[$i];

    try
    {
        $vm = Get-VM -Name $vmName -ErrorAction Stop;

        if ($vm.State -ne "Running")
        {
            return 1; # Critical VM isn't running
        }
    }
    catch
    {
        return 2; # Critical VM doesn't exist
    }
}

return 0; # All OK!