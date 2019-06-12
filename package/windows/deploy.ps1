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

$VENDOR=cattle.io
$DRIVER=log-aggregator

# Assuming the single driver file is located at /$DRIVER inside the DaemonSet image.

$driver_dir=$VENDOR${VENDOR:+"~"}${DRIVER}

Write-Host "driver_dir is $driver_dir"

if (!(Test-Path "/flexmnt/$driver_dir")) {
    mkdir "/flexmnt/$driver_dir"
}

Copy-Item -Path "/usr/bin/$DRIVER" -Destination "/flexmnt/$driver_dir/.$DRIVER"
Move-Item -Path "/flexmnt/$driver_dir/.$DRIVER" -Destination "/flexmnt/$driver_dir/$DRIVER"

while ($true) {
    Start-Sleep -Seconds 3600  
} 



`
$RancherDir = "C:\etc\rancher"
$KubeDir = "C:\etc\kubernetes"
$CNIDir = "C:\etc\cni"

Import-Module "$RancherDir\hns.psm1" -Force

function get-env-var {
    param(
        [parameter(Mandatory = $true)] [string]$Key
    )

    $val = [Environment]::GetEnvironmentVariable($Key, [EnvironmentVariableTarget]::Process)
    if ($val) {
        return $val
    }

    return [Environment]::GetEnvironmentVariable($Key, [EnvironmentVariableTarget]::Machine)
}

## END main definition
#########################################################################
## START main execution

# 0 - success
# 1 - crash
# 2 - agent retry
trap {
    $errMsg = $_.Exception.Message

    popd

    [System.Console]::Error.Write($errMsg)

    if ($errMsg.EndsWith("agent retry")) {
        exit 2
    }

    exit 1
}


# check powershell #
if ($PSVersionTable.PSVersion.Major -lt 5) {
    throw "PowerShell version 5 or higher is required, crash"
}

# check identity #
$currentPrincipal = new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "You need elevated Administrator privileges in order to run this script, start Windows PowerShell by using the Run as Administrator option, crash"
}

try {
    $networkName = get-env-var "KUBE_NETWORK"
    if ($networkName) {
        $null = Clean-HNSNetworks -Names @{
            $networkName = $True
        }
    }

    # rancher #
    Remove-Item -Path "$CNIDir\*" -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path "$KubeDir\*" -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path "$RancherDir\*" -Recurse -Force -ErrorAction Ignore

    # component produces #
    # cni
    Remove-Item -Path "C:\etc\kube-flannel\*" -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path "C:\run\flannel\*" -Recurse -Force -ErrorAction Ignore

    # logs
    Remove-Item -Path "C:\var\log\*" -Recurse -Force -ErrorAction Ignore

    # kuberentes
    Remove-Item -Path "C:\var\lib\rancher\*" -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path "C:\var\lib\kubelet\*" -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path "C:\var\lib\cni\*" -Recurse -Force -ErrorAction Ignore
    Remove-Item -Path "C:\var\lib\etcd\*" -Recurse -Force -ErrorAction Ignore
} catch { }

## END main execution
#########################################################################