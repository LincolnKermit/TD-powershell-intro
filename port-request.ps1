function Get-SystemInfo {
    [string]$Name = hostname
    [string]$WindowsVersion = Get-ComputerInfo -Property WindowsVersion | Select-Object -ExpandProperty WindowsVersion
    [string]$ram = Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object -ExpandProperty Capacity
    [string]$diskfree = Get-CimInstance win32_logicaldisk | where caption -eq "C:" | Select-Object -ExpandProperty FreeSpace
    Write-Output "available $Name, $WindowsVersion, $ram, $diskfree"
}
Get-SystemInfo

Write-Output "Testing Ports..."
function Test-PortOpen {
    param(
        [Parameter(Position=0)]
        [string]$ComputerName = $Name,
        [switch]$ShowDetails
    )
    $Ports = @(80, 443, 3389)
    [int]$try = 1
    ForEach ($port in $Ports) {
        if ($ShowDetails){
            if (Test-NetConnection -ComputerName $ComputerName -Port $Port -Verbose) {
                Write-Output "True"
            }
            else {
                Write-Output "False"
            }
        }
        else{
            if (Test-NetConnection -ComputerName $ComputerName -Port $Port) {
                Write-Output "True"
            }
            else {
                Write-Output "False"
            
            }
        }
    }
}
Test-PortOpen

# ◦	Nom de l'ordinateur
# ◦	Version de Windows
# ◦	Mémoire RAM totale
# ◦	Espace disque disponible
