$Output= @()
$names = Get-content "d:\ip_list.txt"
foreach ($name in $names){
  if (Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue){
   $Output+= "$name,up"
   Write-Host "$Name,up"
  }
  else{
    $Output+= "$name,down"
    Write-Host "$Name,down"
  }
}
$Output | Out-file "d:\result.csv"