#Requires -Version 5.0

param (
)

$ErrorActionPreference = 'Stop'
$WarningPreference = 'SilentlyContinue'
$VerbosePreference = 'SilentlyContinue'
$DebugPreference = 'SilentlyContinue'
$InformationPreference = 'SilentlyContinue'

#########################################################################
## START main definition
Write-Host "Starting log-aggregator"

$VENDOR="cattle.io"
$DRIVER="log-aggregator"
$DRIVER_BIN="log-aggregator.exe"

# Assuming the single driver file is located at /$DRIVER inside the DaemonSet image.

$driver_dir="$VENDOR${VENDOR}~${DRIVER}"

Write-Host "driver_dir is $driver_dir"

if (!(Test-Path "/flexmnt/$driver_dir")) {
    mkdir "/flexmnt/$driver_dir"
}

Copy-Item -Path "/$DRIVER/bin/$DRIVER_BIN" -Destination "/flexmnt/$driver_dir/.$DRIVER_BIN"
Move-Item -Force -Path "/flexmnt/$driver_dir/.$DRIVER_BIN" -Destination "/flexmnt/$driver_dir/$DRIVER_BIN"

while ($true) {
    Start-Sleep -Seconds 3600
}