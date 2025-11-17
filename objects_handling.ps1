$proc = Get-Process
$proc | Get-Member
$proc | Select-Object Name, CPU, WorkingSet
$proc | Select-Object Name, CPU, WorkingSet | Where-Object {$proc.WorkingSet -gt 100MB}
$proc | Select-Object Name, CPU, WorkingSet | Where-Object {$proc.WorkingSet -gt 100MB} | Sort-Object -Property CPU -Descending
$object=[PSCustomObject]@{
  NomProcessus = $proc[0].Name
  MemMB = $proc[0].WorkingSet
  CPUSeconds = $proc[0].CPU
}
$object | ConvertTo-Html | out-file file.html
.\file.html
