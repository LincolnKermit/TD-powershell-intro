function ScanNetwork{
    param(
        [int]$StartIP = 1
        [int]$EndIP = 254
    )
    Write-Output "Test"
    $Network = "192.168.1"
    while ($StartIP -ne $EndIP){
        $ip = "$Network.$StartIP"
        Write-Output "Current test for the IP : " $ip
        $hostname = (Resolve-DnsName -Name $ip -ErrorAction SilentlyContinue | Select-Object -ExpandProperty NameHost)
        Write-Output $hostname
        if ($hostname){
            Write-Output "Hostname found : " $hostname 
        }
        $test = Test-Connection -ComputerName $ip -Count 1 -Quiet
        $StartIP += 1
    }
}
