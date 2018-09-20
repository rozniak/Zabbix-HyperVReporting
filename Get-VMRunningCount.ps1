<#
    .SYNOPSIS
    This script is used for counting the total number of VMs that are currently running
    on this Hyper-V server.

    .DESCRIPTION
    This script utilises the Get-VM cmdlet in order to total up the number of VMs that
    are on this server and running.
    
    .EXAMPLE
    Get-VMRunningCount.ps1

    .NOTES
    Author: Rory Fewell
    GitHub: https://github.com/rozniak
    Website: https://oddmatics.uk
#>

return (Get-VM | Where-Object { $_.State -eq "Running"; }).Length;