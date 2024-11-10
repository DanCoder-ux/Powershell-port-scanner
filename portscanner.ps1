param(
	[string]$target_ip = $args[0]
)

if ( -not $target_ip) {
	Write-Host "`n[i] Usage: .\portscanner.ps1 <target_ip>`n"
	Exit 1
}

foreach ($port in 20.. 65535) {
	$c = New-Object System.Net.Sockets.TcpClient
	$a = $c.BeginConnect($target_ip, $port, $null, $null)
	$r = $a.AsyncWaitHandle.WaitOne(250)

	if ($r) {
		Write-Host -ForegroundColor Cyan "`n[ * ] Port $port/tcp is open!`n"
	} else {
		Write-Host -ForegroundColor Red "[!] Port $port/tcp is closed"
	}
	
	$c.Close()
}
