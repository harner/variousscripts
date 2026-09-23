$portrange = 1..65535
$net = "172.20.10"
$range = 1..20
$timeout_ms = 5
 
foreach ($r in $range)
{
    Get-Date
 
    $ip = "{0}.{1}" -F $net,$r
 
    if (Test-Connection -BufferSize 32 -Count 1 -Quiet -ComputerName $ip)
    {
        Write-Host "IP $ip is alive... checking ports..."
 
        foreach ($port in $portrange)
        {
            $ErrorActionPreference = 'SilentlyContinue'
            $socket = new-object System.Net.Sockets.TcpClient
            $connect = $socket.BeginConnect($ip, $port, $null, $null)
            $tryconnect = Measure-Command { $success = $connect.AsyncWaitHandle.WaitOne($timeout_ms, $true) } | % totalmilliseconds
            $tryconnect | Out-Null
 
            if ($socket.Connected)
            {
                "$ip is listening on port $port (Response Time: $tryconnect ms)"
                $socket.Close()
                $socket.Dispose()
                $socket = $null
            }
 
            $ErrorActionPreference = 'Continue'
        }
 
        Get-Date
    }
}