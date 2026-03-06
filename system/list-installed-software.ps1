<#
.SYNOPSIS
    Lists installed software
.DESCRIPTION
    This PowerShell script lists installed software from the classic
    uninstall registry keys and also includes installed Windows Store apps.
.EXAMPLE
    PS> ./list-installed-software.ps1
.LINK
    https://github.com/it-administrator-mag/PowerShell
.NOTES
    Author: Matthias Heinemann | License: CC0
#>

try {
    $registryApps = Get-ItemProperty `
        HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, `
        HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, `
        HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* `
        -ErrorAction SilentlyContinue |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_.DisplayName) } |
        ForEach-Object {
            [PSCustomObject]@{
                DisplayName    = $_.DisplayName
                DisplayVersion = $_.DisplayVersion
                InstallDate    = $_.InstallDate
                Source         = 'Registry'
            }
        }

    $storeApps = Get-AppxPackage -ErrorAction SilentlyContinue |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_.Name) } |
        ForEach-Object {
            [PSCustomObject]@{
                DisplayName    = if ([string]::IsNullOrWhiteSpace($_.PackageFullName)) { $_.Name } else { $_.Name }
                DisplayVersion = $_.Version.ToString()
                InstallDate    = $null
                Source         = 'StoreApp'
            }
        }

    $allApps = $registryApps + $storeApps |
        Sort-Object DisplayName, DisplayVersion -Unique

    $allApps | Format-Table -AutoSize

    exit 0
} catch {
    "⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
    exit 1
}
