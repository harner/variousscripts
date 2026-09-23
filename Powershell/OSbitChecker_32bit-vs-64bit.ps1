function Get-Architecture {
    # What bitness does Windows use
    $windowsBitness = switch ([Environment]::Is64BitOperatingSystem) {   # needs .NET 4
        $true  { 64; break }
        $false { 32; break }
        default {
            (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture -replace '\D'
            # Or do any of these:
            # (Get-WmiObject -Class Win32_ComputerSystem).SystemType -replace '\D' -replace '86', '32'
            # (Get-WmiObject -Class Win32_Processor).AddressWidth   # slow...
        }
    }

    # What bitness does this PowerShell process use
    $processBitness = [IntPtr]::Size * 8
    # Or do any of these:
    # $processBitness = $env:PROCESSOR_ARCHITECTURE -replace '\D' -replace '86', '32'
    # $processBitness = if ([Environment]::Is64BitProcess) { 64 } else { 32 }

    # Return the info as object
    return New-Object -TypeName PSObject -Property @{
        'ProcessArchitecture' = "{0} bit" -f $processBitness
        'WindowsArchitecture' = "{0} bit" -f $windowsBitness
    }
}

Get-Architecture