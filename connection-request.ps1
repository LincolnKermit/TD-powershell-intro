[string]$machine = "DESKTOP-UCL193QE"
[bool]$status = $false
[int] $attempt = 1
while ($status -eq $false -and $attempt -lt 4){
    Try {
            Write-Output "Attempt number : ", $attempt
            Test-Connection -ComputerName $machine -Count 1 -ErrorAction Stop
            $status = $true
        }
    Catch {
        $status = $false
        Write-Host "Erreur : $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Skill issue"
        $_ | Out-File -Append erreurs.log
        $attempt += 1
    } Finally {
        #
    }
}