$ips = @("8.8.8.8", "google.com", "lalzlalzalzlalzalzlaza.com", "github.com", "fbi.com")
$ips_down = @()
foreach ($ip in $ips){
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    if (Test-connection $ip) {
    } else {
        $ips_down += $ip
    }
    Write-Host "Elapsed time: $($stopwatch.Elapsed.TotalSeconds) seconds"
    $stopwatch.Stop()
}
Write-Host "------------ Host down ------------ "
foreach ($ip_down in $ips_down){
    Write-Host "-", $ip_down
}