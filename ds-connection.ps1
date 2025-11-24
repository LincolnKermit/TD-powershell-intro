function try-connection{
    param(
        [string]$ip = "10.0.0.1"
    )
    [int]$ports = 1024
    [int]$attempt = 1
    while ($ports -gt $attempt){
        test-netconnection -ComputerName $ip -Port $attempt
        $attempt += 1
        Write-Output $attempt
    }
}
try-connection
