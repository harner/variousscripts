Param (
	[string]$SMTPServer = "172.31.16.5",
	[string]$From = "noreply-api@glassbeam.com",
	[string]$To = "chris.harner@glassbeam.com",
	[string]$Subject = "Uptime Status Report - TEST-COLLECTOR-01"
	)

$SMTPMessage = @{
    To = $To
    From = $From
	Subject = "$Subject $uptime"
    Smtpserver = $SMTPServer
}

#Identify Servernames, if using multiples use "host1","host2","host3"
$servers = "localhost"

#Identify today's date
$currentdate = Get-Date

#Identify Hostname
$hostname = hostname

#Logic to determine when the system was rebooted
foreach($server in $servers){
$Bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server).LastBootUpTime
   $uptime = $currentdate - $Bootuptime
   Write-Output "$hostname Uptime : $($uptime.Days) Days"
}

#Send Content
If ($uptime)
{	$SMTPBody = "`nTEST-COLLECTOR-01 Reboot Report:`n`n"
	$uptime | ForEach { $SMTPBody += "$hostname Uptime = $($uptime.Days) Days" }
	Send-MailMessage @SMTPMessage -Body $SMTPBody
}
