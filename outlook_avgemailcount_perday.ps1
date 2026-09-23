# Initialize Outlook COM Object
try {
    $Outlook = New-Object -ComObject Outlook.Application
    $Namespace = $Outlook.GetNamespace("MAPI")
} catch {
    Write-Error "Could not connect to Outlook. Make sure Outlook is installed and running."
    exit
}

# Array to store all received dates
$allDates = [System.Collections.Generic.List[datetime]]::new()

# Function to recursively scan all folders
function Get-EmailStatsFromFolder($folder) {
    # Only process folders that can contain mail items
    if ($folder.DefaultItemType -eq 0) { 
        Write-Progress -Activity "Scanning Outlook Folders" -Status "Processing: $($folder.FolderPath)"
        
        # Retrieve items (restricting to MailItem to avoid meeting requests/tasks throwing errors)
        try {
            $items = $folder.Items
            foreach ($item in $items) {
                # 0x001A is the olMail item type, but checking object type is safer
                if ($item.MessageClass -like "IPM.Note*") {
                    if ($item.ReceivedTime -ne $null) {
                        # Store just the Date component to normalize time
                        $allDates.Add($item.ReceivedTime.Date)
                    }
                }
            }
        } catch {
            # Skip folders that are restricted or empty
        }
    }

    # Recurse into subfolders
    foreach ($subFolder in $folder.Folders) {
        Get-EmailStatsFromFolder $subFolder
    }
}

# Start scanning from the root store(s)
Write-Host "Starting mailbox scan... This may take a few minutes depending on mailbox size." -ForegroundColor Cyan
foreach ($store in $Namespace.Stores) {
    try {
        $rootFolder = $store.GetRootFolder()
        Get-EmailStatsFromFolder $rootFolder
    } catch {
        Write-Warning "Could not access store: $($store.DisplayName)"
    }
}

# Clear progress bar
Write-Progress -Activity "Scanning Outlook Folders" -Completed

# Calculate Metrics
if ($allDates.Count -gt 0) {
    # Group by date to get daily counts
    $groupedDates = $allDates | Group-Object | Select-Object Name, Count
    
    # Sort to find the true span of days active
    $sortedDates = $allDates | Sort-Object
    $oldestDate = $sortedDates[0]
    $newestDate = $sortedDates[-1]
    $totalDaysSpan = ($newestDate - $oldestDate).Days + 1

    # Calculations
    $totalEmails = $allDates.Count
    $averagePerDay = [Math]::Round(($totalEmails / $totalDaysSpan), 2)
    
    # Find peak day
    $peakDay = $groupedDates | Sort-Object Count -Descending | Select-Object -First 1

    # Output Results
    Write-Host "`n=== Outlook Email Statistics ===" -ForegroundColor Green
    Write-Host "Total Emails Found:   " -NoNewline; Write-Host $totalEmails -ForegroundColor Yellow
    Write-Host "Date Range Analyzed:  " -NoNewline; Write-Host "$($oldestDate.ToShortDateString()) to $($newestDate.ToShortDateString()) ($totalDaysSpan days)" -ForegroundColor Yellow
    Write-Host "Average Recieved/Day: " -NoNewline; Write-Host $averagePerDay -ForegroundColor Green
    Write-Host "Highest Volume Day:   " -NoNewline; Write-Host "$($peakDay.Name) ($($peakDay.Count) emails)" -ForegroundColor Yellow
    Write-Host "================================" -ForegroundColor Green
} else {
    Write-Host "No emails found to analyze." -ForegroundColor Red
}

# Clean up COM objects
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($Namespace) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($Outlook) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()