# BACKUP Brave Browser Favorites

$SourcePath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Bookmarks"

$BackupDirectory = "$env:C:\Users\chris.harner\OneDrive - glassbeam.com\Documents\Important\Backups\Favorites"

$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupFileName = "bookmarks_$Timestamp.json" # Brave's bookmarks are in JSON format

If (-not (Test-Path $BackupDirectory)) {
    New-Item -Path $BackupDirectory -ItemType Directory | Out-Null
    Write-Host "Created backup directory: $BackupDirectory"
}

Try {
    Copy-Item -Path $SourcePath -Destination (Join-Path $BackupDirectory $BackupFileName) -Force -ErrorAction Stop
    Write-Host "Brave bookmarks backed up successfully to: $(Join-Path $BackupDirectory $BackupFileName)"
}
Catch {
    Write-Error "Failed to back up Brave bookmarks. Error: $($_.Exception.Message)"
}

# BACKUP mRemoteNG Connection Settings
# TBD

# BACKUP Virtual Machines and Settings
Robocopy "C:\Users\chris.harner\VM" "D:\Backups\VM" /MIR /Z /FFT /Z /XA:H /W:5 /XD websockify BatchFiles

# BACKUP Local Outlook Files
Robocopy "C:\Users\chris.harner\OneDrive - glassbeam.com\Documents\Outlook Files" "D:\Backups\Outlook Files" /MIR /Z /FFT /Z /XA:H /W:5 /XD websockify BatchFiles

# FINAL Copy Important Directory to External HDD
Robocopy "C:\Users\chris.harner\OneDrive - glassbeam.com\Documents\Important" "D:\Backups\Important" /MIR /Z /FFT /Z /XA:H /W:5 /XD websockify BatchFiles