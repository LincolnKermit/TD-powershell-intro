# 1.	Listez toutes les interfaces réseau actives
# 2.	Affichez la configuration IP complète de votre interface principale
# 3.	Créez un script qui génère un rapport des interfaces avec :
# ◦	Nom de l'interface
# ◦	Adresse MAC
# ◦	Adresse IP
# ◦	Passerelle par défaut
# ◦	Serveurs DNS
# 4.	Affichez les statistiques réseau (paquets envoyés/reçus)
# 5.	Exportez le rapport en HTML avec mise en forme

[string]$ip = (Get-NetIPAddress -InterfaceAlias "network_ciel").ipv4address
[string]$mac = Get-NetAdapter | Where-Object { $_.Name -match "network_ciel" } | Select-Object -ExpandProperty MacAddress
[string]$dns = Get-DnsClientServerAddress -InterfaceAlias "network_ciel" | Select-Object -ExpandProperty ServerAddresses -First 1 | Select-Object -First 1
$gateway = (Get-WmiObject Win32_networkAdapterConfiguration | Where-Object {$_.IPEnabled}).DefaultIPGateway | Select-Object -First 1

# HTML header with CSS styling
$htmlHeader = @"
<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        h1 { color: #333; text-align: center; }
        table { width: 100%; border-collapse: collapse; background-color: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        th { background-color: #4CAF50; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #ddd; }
        tr:hover { background-color: #f5f5f5; }
    </style>
</head>
<body>
    <h1>Network Configuration Report</h1>
"@

# Create custom object and convert to HTML
$report = [PSCustomObject]@{
    'IP Address' = $ip
    'MAC Address' = $mac
    'DNS Server' = $dns
    'Default Gateway' = $gateway
}

$htmlBody = $report | ConvertTo-Html -Fragment
$htmlFooter = "</body></html>"

# Combine and save
($htmlHeader + $htmlBody + $htmlFooter) | Out-File -FilePath "network_report.html"