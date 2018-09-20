<#
    .SYNOPSIS
    This script is used for counting the total number of VMs on this Hyper-V server.

    .DESCRIPTION
    This script utilises the Get-VM cmdlet in order to total up the number of VMs that
    are on this server (not limited to running ones).
    
    .EXAMPLE
    Get-VMCount.ps1

    .NOTES
    Author: Rory Fewell
    GitHub: https://github.com/rozniak
    Website: https://oddmatics.uk
#>

return (Get-VM).Length;