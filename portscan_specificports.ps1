$target = "34.192.206.55"
22,23,80,135,139,443,445,3389,5900,5901,8080 | % {echo ((New-Object net.sockets.tcpclient).connect("$target",$_)) "$target has port $_ open"} 2>out-null