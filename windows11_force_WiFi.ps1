# Allow-Only-EPIC-WiFi.ps1
# Purpose: Only allow connection to "EPIC-CompSci-WiFi-5GHz"

$allowedSSID = "EPIC-CompSci-WiFi-5GHz"

Write-Host "Clearing all existing Wi-Fi profiles..." -ForegroundColor Yellow
netsh wlan delete profile name=* | Out-Null

Write-Host "Creating allowed Wi-Fi profile for $allowedSSID ..." -ForegroundColor Yellow
# Optional: you can manually connect once before running this script so Windows saves the proper encryption settings
netsh wlan add profile filename="C:\ProgramData\Microsoft\Wlansvc\Profiles\Interfaces\*" | Out-Null

Write-Host "Configuring WLAN filters..." -ForegroundColor Yellow
# Block all except allowed SSID
netsh wlan add filter permission=block ssid=all networktype=infrastructure
netsh wlan add filter permission=allow ssid=$allowedSSID networktype=infrastructure

Write-Host "Policy applied! Only $allowedSSID is now allowed." -ForegroundColor Green
