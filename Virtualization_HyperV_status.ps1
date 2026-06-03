#Requires -RunAsAdministrator

# Check VBS status
$vbsStatusMap = @{ 0 = "Off"; 1 = "Configured (not running)"; 2 = "Running" }
$vbs = (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard).VirtualizationBasedSecurityStatus
$vbsStatus = $vbsStatusMap[[int]$vbs]

# Determine who is setting the VBS policy
$vbsGpValue    = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" -Name EnableVirtualizationBasedSecurity -ErrorAction SilentlyContinue
$vbsLocalValue = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name EnableVirtualizationBasedSecurity -ErrorAction SilentlyContinue
$vbsMdmEnrolled = (Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Enrollments" -ErrorAction SilentlyContinue).Count -gt 0
$vbsPolicySource = if ($vbsGpValue -and $vbsMdmEnrolled) {
    "MDM (e.g. Intune)"
} elseif ($vbsGpValue) {
    "Group Policy"
} elseif ($vbsLocalValue) {
    "Local Policy (registry)"
} else {
    "Not explicitly configured"
}

# Check which VBS services are running
$vbServiceMap = @{
    1 = "Credential Guard"
    2 = "HVCI (Memory Integrity)"
    3 = "System Guard Secure Launch"
    4 = "SMM Firmware Measurement"
}
$vbsRunningServices = (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard).SecurityServicesRunning

# Get Hyper-V related optional features
$hvFeatures = Get-WindowsOptionalFeature -Online |
    Where-Object { $_.FeatureName -match "Hyper-V|HyperV|VirtualMachine|Hypervisor" }

# Print a table
$rows = @(
    [PSCustomObject]@{
        Feature         = "Virtualization Based Security (VBS)"
        Status          = "$vbsStatus ($vbs)"
        "Policy Source" = $vbsPolicySource
    }
)
$allIds = (($vbServiceMap.Keys | ForEach-Object { [int]$_ }) + ($vbsRunningServices | ForEach-Object { [int]$_ })) | Sort-Object -Unique
foreach ($id in $allIds) {
    $name = if ($vbServiceMap.ContainsKey($id)) { $vbServiceMap[$id] } else { "Unknown Service (ID: $id)" }
    $rows += [PSCustomObject]@{
        Feature         = "$name"
        Status          = if ($vbsRunningServices -contains $id) { "Running" } else { "Not running" }
        "Policy Source" = ""
    }
}
foreach ($f in $hvFeatures) {
    $rows += [PSCustomObject]@{
        Feature         = $f.FeatureName
        Status          = $f.State
        "Policy Source" = ""
    }
}
$rows | Format-Table -AutoSize
