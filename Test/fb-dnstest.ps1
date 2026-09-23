$Computers = Get-Content Z:\Tech\Scripts\Test\fb.txt
Test-Connection  -ComputerName $Computers | Out-File Z:\Tech\Scripts\Test\results.csv
