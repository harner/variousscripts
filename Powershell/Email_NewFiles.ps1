Param (
	[string]$Path = "C:\Glassbeam\Receiver\alert_output",
	[string]$SMTPServer = "172.31.16.5",
	[string]$From = "noreply-api@glassbeam.com",
	[string]$To = "chris.harner@glassbeam.com",
	[string]$Subject = "New File In Path:"
	)

$SMTPMessage = @{
    To = $To
    From = $From
	Subject = "$Subject $Path"
    Smtpserver = $SMTPServer
}

$File = Get-ChildItem $Path | Where { $_.LastWriteTime -ge [datetime]::Now.AddMinutes(-10) }
If ($File)
{	$SMTPBody = "`nThe following files have recently been added/changed:`n`n"
	$File | ForEach { $SMTPBody += "$($_.FullName)`n" }
	Send-MailMessage @SMTPMessage -Body $SMTPBody
	
}