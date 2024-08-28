param (
    [string]$packageName
)

if (-not $packageName) {
    Write-Host "Usage: .\CreateSCSPackage.ps1 -packageName <name of package>"
    exit 1
}

dotnet sitecore ser pkg create -o ./dist/$packageName