# 20170222 - This script will deploy against the specified folder and purge up to 1GB of data.


# Specify the folder to run this script against
$pathToDelete = "C:\testdeletes"
# Keep total of what is deleted (do not modify)
$currentlyDeletedAmount = 0
# Formula for purging 1GB
$maxSizeToDeleteMB = 1
$maxSizeToDelete = $maxSizeToDeleteMB * 1024 * 1024


Get-ChildItem $pathToDelete -Recurse | Foreach($_) { 

    Write-Host $_.Length $_.FullName 

    Write-Host $_.GetType()

        If($_.GetType() -eq [System.IO.DirectoryInfo])
        {
            Write-Host (Get-ChildItem $_.FullName | Select-Object -First 1 | Measure-Object).Count 
            if((Get-ChildItem $_.FullName | Select-Object -First 1 | Measure-Object).Count -eq 0)
            {
                Remove-Item $_.FullName
            }
        }
        else
        {
            $currentlyDeletedAmount = $currentlyDeletedAmount + $_.Length
            Write-Host $currentlyDeletedAmount
            If($currentlyDeletedAmount -gt $maxSizeToDelete)
            {
                break;
            }
            Remove-Item $_.FullName
        }
} 

# Example v1.1 code for adding email during a constant script
# Send-MailMessage -Body "IHE_SJHS_FN was broken and has been restarted" –From "frank.kremm@mobilemd.com" -To "frank.kremm@cerner.com" –Priority "Normal" –SmtpServer "hiewebdev01" –Subject "IHE_SJHS_FN was broken and has been restarted"