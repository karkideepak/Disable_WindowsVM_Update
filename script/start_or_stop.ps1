# ------------------------------------------------------------
# Script Name: Manage-WindowsUpdate.ps1
# Purpose   : Start or Stop the Windows Update service
# Service   : wuauserv
# ------------------------------------------------------------

# Store the service name in a variable
$serviceName = "wuauserv"

# Get the current service object
$service = Get-Service -Name $serviceName

# Display current status before doing anything
Write-Host "Current Status of Windows Update:" -ForegroundColor Cyan
Get-Service $serviceName | Select Status, StartType
Write-Host "----------------------------------------"

# ------------------------------------------------------------
# Check if the service is running or stopped
# ------------------------------------------------------------

If ($service.Status -eq "Running") {

    Write-Host "Windows Update is running. Stopping it now..." -ForegroundColor Yellow

    # Stop the service
    Stop-Service -Name $serviceName -Force

}
Else {

    Write-Host "Windows Update is stopped. Starting it now..." -ForegroundColor Yellow

    # If startup type is Disabled, change it first
    If ($service.StartType -eq "Disabled") {
        Write-Host "Startup type is Disabled. Changing to Manual..." -ForegroundColor Yellow
        Set-Service -Name $serviceName -StartupType Manual
    }

    # Start the service
    Start-Service -Name $serviceName
}

# ------------------------------------------------------------
# Refresh service info and show final result
# ------------------------------------------------------------

$service.Refresh()

Write-Host "Final Status of Windows Update:" -ForegroundColor Cyan
Get-Service $serviceName | Select Status, StartType

# ------------------------------------------------------------
# Success / Failure message
# ------------------------------------------------------------

If ($service.Status -eq "Running") {
    Write-Host "SUCCESS: Windows Update service is RUNNING." -ForegroundColor Green
}
ElseIf ($service.Status -eq "Stopped") {
    Write-Host "SUCCESS: Windows Update service is STOPPED." -ForegroundColor Green
}
Else {
    Write-Host "FAILED: Unable to determine service state." -ForegroundColor Red
}
