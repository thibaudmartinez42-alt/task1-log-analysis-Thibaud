<#
.SYNOPSIS
Windows Automation Script - Task 8
#>
$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

# Export active processes to CSV
Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet | Export-Csv -Path "C:\backups\processes_$Timestamp.csv" -NoTypeInformation

# Perform automatic folder backups
Copy-Item -Path "C:\ImportantData" -Destination "C:\backups\Data_$Timestamp" -Recurse -Force

# Trigger alert if CPU usage exceeds 80%
$CPU = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
if ($CPU -gt 80) {
    Write-Host "[ALERT] High CPU Usage detected: $CPU%" -ForegroundColor Red
} else {
    Write-Host "[INFO] CPU Usage is stable at $CPU%" -ForegroundColor Green
}
