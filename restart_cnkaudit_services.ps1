$svcName = "Genapi.NotaPlusToCNKAudit"
$services = Get-WmiObject win32_service | Where-Object { $_.PathName -like "*$svcName*" }

foreach ($svc in $services) {

Write-Output "---------------------------------------"
Write-Output "Name=$($svc.Name)"
Write-Output "DisplayName=$($svc.DisplayName)"
Write-Output "State=$($svc.State)"
Write-Output "PathName=$($svc.PathName)"

Stop-Service -Name $svc.Name
$tempSvc = Get-Service -Name $svc.Name
if ($tempSvc.Status -ne "Stopped") {
Write-Output "Could not stop service $($svc.Name)"
}
else {
Write-Output "Successfully stopped service $($svc.Name)"
}

Start-Service -Name $svc.Name
$tempSvc = Get-Service -Name $svc.Name
if ($tempSvc.Status -eq "Running") {
Write-Output "Service $($svc.Name) Restarted"
}
else {
Write-Output "Cannot restart $($svc.Name)"
}
}

if (($services | Measure-Object).Count -le 0) {
Write-Output "Couldn't find cnkaudit services"
}