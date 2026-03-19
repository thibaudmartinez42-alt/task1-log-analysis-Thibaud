# This script sets up a weekly Windows Scheduled Task for the log analyzer
$Action = New-ScheduledTaskAction -Execute "python" -Argument "$PSScriptRoot\log_analyzer.py" -WorkingDirectory "$PSScriptRoot"
$Trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 9am
Register-ScheduledTask -TaskName "Task1_WeeklyLogAnalysis" -Action $Action -Trigger $Trigger -RunLevel Highest -Force

Write-Host "Scheduled task created successfully. The log analysis will run automatically every Monday at 9 AM."
