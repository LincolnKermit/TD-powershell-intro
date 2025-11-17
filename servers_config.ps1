$serveurs = @("LYS-001", "NYC-001","PAR-001","HKG-001","WDC-001") 
$serveurs += "MIL-001"
Write-Output $serveurs[2]



$serveurInfo = @{ Nom = 'LYS-001', IP = '92.183.194.12', OS = 'debian-12', RAM = '4096' }
# Write the ip of our server in $serveurInfo
$serveurInfo["IP"]
